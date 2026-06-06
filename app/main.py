from __future__ import annotations

from fastapi import FastAPI, HTTPException, Query, Request
from fastapi.responses import HTMLResponse, Response
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

from app.content import (
    BASE_DIR,
    get_archive_sources,
    get_experience,
    get_featured_projects,
    get_profile,
    get_project,
    get_project_tags,
    get_projects,
)
from app.heinz_carousel import build_worldcarousel_xml


app = FastAPI(
    title="Tony Destro Portfolio",
    description="Principal software engineer portfolio and selected projects.",
)

app.mount("/static", StaticFiles(directory=BASE_DIR / "static"), name="static")

PROJECT_DIR = BASE_DIR.parent
HEINZ_LEGACY_MENU_DIR = PROJECT_DIR / "legacy/public-html/flash/worldcarousel/menu"
if HEINZ_LEGACY_MENU_DIR.exists():
    app.mount(
        "/flash/worldcarousel/menu",
        StaticFiles(directory=HEINZ_LEGACY_MENU_DIR),
        name="heinz_legacy_menu",
    )

templates = Jinja2Templates(directory=BASE_DIR / "templates")


def static_url(path: str) -> str:
    return f"/static/{path.lstrip('/')}"


templates.env.globals["static_url"] = static_url


def context(request: Request, **extra: object) -> dict[str, object]:
    data: dict[str, object] = {
        "request": request,
        "profile": get_profile(),
        "path": request.url.path,
    }
    data.update(extra)
    return data


@app.get("/healthz")
@app.get("/health")
def healthz() -> dict[str, str]:
    return {"status": "ok"}


@app.get("/flash/worldcarousel/worldcarousel.aspx")
def heinz_worldcarousel(
    hours: float = Query(..., ge=0, lt=24),
    utc_offset: float = Query(..., alias="utcOffset"),
    domain_prefix: str | None = Query(None, alias="domainPrefix"),
) -> Response:
    try:
        xml = build_worldcarousel_xml(
            hours=hours,
            utc_offset=utc_offset,
            domain_prefix=domain_prefix,
        )
    except ValueError as exc:
        raise HTTPException(status_code=400, detail=str(exc)) from exc

    return Response(content=xml, media_type="text/xml")


@app.get("/", response_class=HTMLResponse)
def home(request: Request) -> HTMLResponse:
    return templates.TemplateResponse(
        request,
        "index.html",
        context(
            request,
            featured_projects=get_featured_projects(6),
            all_projects=get_projects(),
            archive_sources=get_archive_sources(),
            experience=get_experience(),
        ),
    )


@app.get("/projects", response_class=HTMLResponse)
def projects(request: Request) -> HTMLResponse:
    return templates.TemplateResponse(
        request,
        "projects.html",
        context(request, projects=get_projects(), tags=get_project_tags()),
    )


@app.get("/projects/{slug}", response_class=HTMLResponse)
def project_detail(request: Request, slug: str) -> HTMLResponse:
    project = get_project(slug)
    if project is None:
        raise HTTPException(status_code=404, detail="Project not found")

    return templates.TemplateResponse(
        request,
        "project.html",
        context(request, project=project),
    )


@app.get("/resume", response_class=HTMLResponse)
def resume(request: Request) -> HTMLResponse:
    return templates.TemplateResponse(
        request,
        "resume.html",
        context(request, experience=get_experience(), projects=get_featured_projects(4)),
    )


@app.get("/contact", response_class=HTMLResponse)
def contact(request: Request) -> HTMLResponse:
    return templates.TemplateResponse(request, "contact.html", context(request))
