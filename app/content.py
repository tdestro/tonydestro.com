from __future__ import annotations

import json
from functools import lru_cache
from pathlib import Path
from typing import Any


BASE_DIR = Path(__file__).resolve().parent
DATA_DIR = BASE_DIR / "data"


def _load_json(name: str) -> Any:
    path = DATA_DIR / name
    with path.open("r", encoding="utf-8") as handle:
        return json.load(handle)


@lru_cache
def get_profile() -> dict[str, Any]:
    return _load_json("profile.json")


@lru_cache
def get_projects() -> list[dict[str, Any]]:
    projects = _load_json("projects.json")
    return sorted(
        projects,
        key=lambda item: (
            not item.get("featured", False),
            item.get("priority", 100),
            item["title"],
        ),
    )


@lru_cache
def get_experience() -> list[dict[str, Any]]:
    return _load_json("experience.json")


@lru_cache
def get_archive_sources() -> list[dict[str, Any]]:
    return _load_json("archive_sources.json")


def get_project(slug: str) -> dict[str, Any] | None:
    return next((project for project in get_projects() if project["slug"] == slug), None)


def get_featured_projects(limit: int = 6) -> list[dict[str, Any]]:
    featured = [project for project in get_projects() if project.get("featured")]
    return featured[:limit]


def get_project_tags() -> list[str]:
    tags: set[str] = set()
    for project in get_projects():
        tags.update(project.get("tags", []))
    return sorted(tags)
