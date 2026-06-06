from __future__ import annotations

from dataclasses import dataclass
from functools import lru_cache
from pathlib import Path
from xml.etree import ElementTree


HEINZ_MENU_XML = Path(__file__).resolve().parent / "static/images/archive/heinz-worldcarousel/menu.xml"
DEFAULT_ASSET_PREFIX = "/static/images/archive/heinz-worldcarousel/menu/"


@dataclass(frozen=True)
class HeinzMenuItem:
    attrs: dict[str, str]
    lower_hour: float
    upper_hour: float
    meal_dir: str
    zone: int
    virtual_globe: int
    utc_offset: float


def build_worldcarousel_xml(
    *,
    hours: float,
    utc_offset: float,
    domain_prefix: str | None = None,
) -> str:
    """Recreate the recovered Heinz worldcarousel.aspx XML response."""
    if not 0 <= hours < 24:
        raise ValueError("hours must be in the range 0 <= hours < 24")

    selected_item = _select_closest_item(hours, utc_offset)
    globe_items = _items_for_globe(selected_item.virtual_globe)
    prefix = _normalize_asset_prefix(domain_prefix)

    root = ElementTree.Element("heinz")
    items_el = ElementTree.SubElement(root, "items", {"width": "400", "height": "226"})

    ordered_items = _ordered_from_zone(globe_items, selected_item.zone)
    for index, item in enumerate(ordered_items):
        attrs = dict(item.attrs)
        attrs["href"] = f"{prefix}{item.meal_dir}{item.attrs['href']}"
        attrs["hrefbt"] = f"{prefix}{item.attrs['hrefbt']}"
        attrs["id"] = str(index)
        ElementTree.SubElement(items_el, "item", attrs)

    return ElementTree.tostring(root, encoding="unicode", short_empty_elements=True)


def _select_closest_item(hours: float, utc_offset: float) -> HeinzMenuItem:
    meal_items = [
        item
        for item in _load_items()
        if _hour_in_meal(hours, item.lower_hour, item.upper_hour)
    ]
    if not meal_items:
        meal_items = [
            item
            for item in _load_items()
            if item.lower_hour > item.upper_hour
        ]

    target_offset = utc_offset + 13
    if target_offset <= 0:
        raise ValueError("utcOffset must be greater than -13")

    exact = next(
        (
            item
            for item in meal_items
            if item.utc_offset + 13 == target_offset
        ),
        None,
    )
    if exact is not None:
        return exact

    return min(
        meal_items,
        key=lambda item: _ratio(item.utc_offset + 13, target_offset),
    )


def _hour_in_meal(hours: float, lower: float, upper: float) -> bool:
    return lower <= hours < upper


def _ratio(item_offset: float, target_offset: float) -> float:
    if item_offset < target_offset:
        return target_offset / item_offset
    return item_offset / target_offset


def _items_for_globe(virtual_globe: int) -> list[HeinzMenuItem]:
    items = [
        item
        for item in _load_items()
        if item.virtual_globe == virtual_globe
    ]
    return sorted(items, key=lambda item: item.zone)


def _ordered_from_zone(items: list[HeinzMenuItem], start_zone: int) -> list[HeinzMenuItem]:
    by_zone = {item.zone: item for item in items}
    return [
        by_zone[zone]
        for zone in [*range(start_zone, len(items)), *range(0, start_zone)]
        if zone in by_zone
    ]


def _normalize_asset_prefix(domain_prefix: str | None) -> str:
    prefix = domain_prefix or DEFAULT_ASSET_PREFIX
    return prefix if prefix.endswith("/") else f"{prefix}/"


@lru_cache
def _load_items() -> tuple[HeinzMenuItem, ...]:
    root = ElementTree.parse(HEINZ_MENU_XML).getroot()
    items: list[HeinzMenuItem] = []

    for meal in root.findall("meal"):
        meal_dir = meal.attrib["dir"]
        lower_hour = float(meal.attrib["LowerLimitHours"])
        upper_hour = float(meal.attrib["UpperLimitHours"])

        for item in meal.findall("item"):
            attrs = dict(item.attrib)
            items.append(
                HeinzMenuItem(
                    attrs=attrs,
                    lower_hour=lower_hour,
                    upper_hour=upper_hour,
                    meal_dir=meal_dir,
                    zone=int(attrs["zone"].strip()),
                    virtual_globe=int(attrs["virtualGlobe"].strip()),
                    utc_offset=float(attrs["utcOffset"].strip()),
                )
            )

    return tuple(items)
