import * as THREE from "/static/vendor/three.module.min.js";

const roots = document.querySelectorAll("[data-hsfl-panorama]");
const cleanupKey = "__healthySightPanoramaCleanup";
const initTokenKey = "__healthySightPanoramaInitToken";
const worldScale = 0.001;
const foregroundScale = 0.00145;
const kiteScale = 0.0012;
const kiteImageSize = { width: 232, height: 261 };
const degToRad = THREE.MathUtils.degToRad;

const scenes = [
  {
    title: "Outdoors",
    dae: "wireframes/Panorama_1/Panorama_1_with_FG_v05.dae",
    cameraZ: 50,
    fov: 38,
    xRange: 70,
    yRange: 5,
    yawMin: -8,
    yawMax: 16,
    pitchMin: -4,
    pitchMax: 2.5,
    modelPosition: [0, 10, 300],
    modelRotation: [0, 270, 0],
    kite: true,
    foregrounds: [
      {
        url: "wireframes/Panorama_1/panorama1_fg.png",
        width: 407,
        height: 600,
        position: [200, -50, 920],
      },
    ],
  },
  {
    title: "Nature",
    dae: "wireframes/Panorama_2/Panorama2_v01.dae",
    cameraZ: -850,
    fov: 39,
    xRange: 75,
    yRange: 5,
    yawMin: -8,
    yawMax: 16,
    pitchMin: -4,
    pitchMax: 1.4,
    modelPosition: [0, 0, 0],
    modelRotation: [0, 270, 0],
    foregrounds: [
      {
        url: "wireframes/Panorama_2/Panoram2_fg.png",
        width: 795,
        height: 711,
        position: [300, -200, 200],
      },
    ],
  },
  {
    title: "Home",
    dae: "wireframes/Panorama_3/Panorama_3_v01.dae",
    cameraZ: -850,
    fov: 38,
    xRange: 75,
    yRange: 5,
    yawMin: -8,
    yawMax: 15,
    pitchMin: -4,
    pitchMax: 1.4,
    modelPosition: [0, 50, 0],
    modelRotation: [0, 270, 0],
    foregrounds: [
      {
        url: "wireframes/Panorama_3/House_Couple.png",
        width: 319,
        height: 339,
        position: [200, -50, -350],
      },
    ],
  },
  {
    title: "Work",
    dae: "wireframes/Panorama_4/Panorama4_v02.dae",
    cameraZ: -800,
    fov: 39,
    xRange: 75,
    yRange: 5,
    yawMin: -7,
    yawMax: 13,
    pitchMin: -3.5,
    pitchMax: 2.2,
    modelPosition: [0, 0, 0],
    modelRotation: [0, 270, 0],
    foregrounds: [
      {
        url: "wireframes/Panorama_4/Pano4_FG_2.png",
        width: 942,
        height: 915,
        position: [-820, -210, 540],
      },
      {
        url: "wireframes/Panorama_4/Pano4_FG_1.png",
        width: 500,
        height: 710,
        position: [390, -140, 1],
      },
    ],
  },
];

const effects = {
  healthy: null,
  cataracts: "images/disease_pngs/cataracts.png",
  glaucoma: "images/disease_pngs/glaucoma.png",
  retinopathy: "images/disease_pngs/diabeticRetinopathy.png?v=drive-red-1",
};

function cleanupRoot(root) {
  if (typeof root[cleanupKey] === "function") {
    root[cleanupKey]();
    root[cleanupKey] = undefined;
  }
  root[initTokenKey] = undefined;
}

function childrenByName(node, name) {
  return Array.from(node?.children || []).filter((child) => child.localName === name);
}

function allByName(node, name) {
  return Array.from(node?.getElementsByTagName("*") || []).filter((child) => child.localName === name);
}

function firstByName(node, name) {
  return allByName(node, name)[0] || null;
}

function textOf(node, name) {
  return firstByName(node, name)?.textContent.trim() || "";
}

function parseNumbers(value) {
  return value.trim().split(/\s+/).map(Number);
}

function stripHash(value) {
  return (value || "").replace(/^#/, "");
}

function assetUrl(base, path) {
  const normalizedBase = base.endsWith("/") ? base : `${base}/`;
  const baseUrl = /^https?:\/\//i.test(normalizedBase)
    ? normalizedBase
    : `${window.location.origin}${normalizedBase}`;
  return new URL(path, baseUrl).toString();
}

function colladaToThree(values, index, scale = worldScale) {
  const x = values[index] * scale;
  const y = values[index + 2] * scale;
  const z = values[index + 1] * scale;
  return [x, y, z];
}

function actionScriptToThree(position, scale = worldScale) {
  return new THREE.Vector3(position[0] * scale, position[1] * scale, position[2] * scale);
}

function readSource(source) {
  const id = source.getAttribute("id");
  const floatArray = firstByName(source, "float_array");
  const accessor = firstByName(source, "accessor");
  return {
    id,
    data: parseNumbers(floatArray?.textContent || ""),
    stride: Number(accessor?.getAttribute("stride") || 1),
  };
}

function readMaterials(doc) {
  const images = new Map();
  const effectsByImage = new Map();
  const materialsByImage = new Map();

  for (const image of allByName(doc, "image")) {
    images.set(image.getAttribute("id"), textOf(image, "init_from"));
  }

  for (const effect of allByName(doc, "effect")) {
    const texture = firstByName(effect, "texture");
    if (!texture) {
      continue;
    }

    const samplerId = texture.getAttribute("texture");
    let surfaceId = "";
    for (const param of allByName(effect, "newparam")) {
      if (param.getAttribute("sid") === samplerId) {
        surfaceId = textOf(param, "source");
      }
    }

    let imageId = "";
    for (const param of allByName(effect, "newparam")) {
      if (param.getAttribute("sid") === surfaceId) {
        imageId = textOf(param, "init_from");
      }
    }

    effectsByImage.set(effect.getAttribute("id"), images.get(imageId));
  }

  for (const material of allByName(doc, "material")) {
    const instanceEffect = firstByName(material, "instance_effect");
    const effectId = stripHash(instanceEffect?.getAttribute("url"));
    materialsByImage.set(material.getAttribute("id"), effectsByImage.get(effectId));
  }

  return materialsByImage;
}

function parseGeometry(geometry) {
  const mesh = firstByName(geometry, "mesh");
  const sources = new Map();
  const vertices = new Map();
  const parts = [];

  for (const source of childrenByName(mesh, "source")) {
    const parsed = readSource(source);
    sources.set(parsed.id, parsed);
  }

  for (const vertex of childrenByName(mesh, "vertices")) {
    const positionInput = childrenByName(vertex, "input").find(
      (input) => input.getAttribute("semantic") === "POSITION"
    );
    vertices.set(vertex.getAttribute("id"), stripHash(positionInput?.getAttribute("source")));
  }

  for (const triangles of childrenByName(mesh, "triangles")) {
    const inputs = childrenByName(triangles, "input").map((input) => ({
      offset: Number(input.getAttribute("offset") || 0),
      semantic: input.getAttribute("semantic"),
      source: stripHash(input.getAttribute("source")),
    }));
    const stride = Math.max(...inputs.map((input) => input.offset)) + 1;
    const positionInput = inputs.find((input) => input.semantic === "VERTEX" || input.semantic === "POSITION");
    const uvInput = inputs.find((input) => input.semantic === "TEXCOORD");
    const normalInput = inputs.find((input) => input.semantic === "NORMAL");
    const positionSource = sources.get(vertices.get(positionInput.source) || positionInput.source);
    const uvSource = uvInput ? sources.get(uvInput.source) : null;
    const normalSource = normalInput ? sources.get(normalInput.source) : null;
    const indices = parseNumbers(firstByName(triangles, "p")?.textContent || "");
    const positions = [];
    const uvs = [];
    const normals = [];

    for (let i = 0; i < indices.length; i += stride) {
      const positionIndex = indices[i + positionInput.offset] * positionSource.stride;
      positions.push(...colladaToThree(positionSource.data, positionIndex));

      if (uvInput && uvSource) {
        const uvIndex = indices[i + uvInput.offset] * uvSource.stride;
        uvs.push(uvSource.data[uvIndex], uvSource.data[uvIndex + 1]);
      }

      if (normalInput && normalSource) {
        const normalIndex = indices[i + normalInput.offset] * normalSource.stride;
        normals.push(...colladaToThree(normalSource.data, normalIndex, 1));
      }
    }

    parts.push({
      material: triangles.getAttribute("material"),
      positions,
      uvs,
      normals,
    });
  }

  return parts;
}

function applyNodeTransform(node, object) {
  const translate = textOf(node, "translate");
  const scale = textOf(node, "scale");

  if (translate) {
    const values = parseNumbers(translate);
    object.position.set(...colladaToThree(values, 0));
  }

  for (const rotation of childrenByName(node, "rotate")) {
    const [x, y, z, degrees] = parseNumbers(rotation.textContent);
    const axis = new THREE.Vector3(x, z, y).normalize();
    if (axis.lengthSq() > 0) {
      object.rotateOnAxis(axis, degToRad(degrees));
    }
  }

  if (scale) {
    const values = parseNumbers(scale);
    object.scale.set(values[0], values[2], values[1]);
  }
}

function createTextureLoader(renderer) {
  const loader = new THREE.TextureLoader();
  const cache = new Map();

  return function loadTexture(url) {
    if (!cache.has(url)) {
      cache.set(
        url,
        new Promise((resolve, reject) => {
          loader.load(
            url,
            (texture) => {
              texture.colorSpace = THREE.SRGBColorSpace;
              texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
              texture.minFilter = THREE.LinearMipmapLinearFilter;
              texture.magFilter = THREE.LinearFilter;
              resolve(texture);
            },
            undefined,
            () => reject(new Error(`Unable to load Healthy Sight asset: ${url}`))
          );
        })
      );
    }
    return cache.get(url);
  };
}

async function loadColladaObject(url, textureBase, renderer, loadTexture) {
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`Healthy Sight Collada scene returned ${response.status}: ${url}`);
  }

  const doc = new DOMParser().parseFromString(await response.text(), "application/xml");
  if (firstByName(doc, "parsererror")) {
    throw new Error(`Invalid Healthy Sight Collada scene: ${url}`);
  }

  const materialImages = readMaterials(doc);
  const materialTextures = new Map();
  for (const [material, image] of materialImages) {
    if (image) {
      materialTextures.set(material, await loadTexture(assetUrl(textureBase, image)));
    }
  }

  const geometries = new Map();
  for (const geometry of allByName(doc, "geometry")) {
    geometries.set(geometry.getAttribute("id"), parseGeometry(geometry));
  }

  const visualSceneId = stripHash(firstByName(firstByName(doc, "scene"), "instance_visual_scene")?.getAttribute("url"));
  const visualScenes = allByName(doc, "visual_scene");
  const visualScene =
    visualScenes.find((scene) => scene.getAttribute("id") === visualSceneId) ||
    visualScenes.find((scene) => childrenByName(scene, "node").some((node) => firstByName(node, "instance_geometry")));

  if (!visualScene) {
    throw new Error(`Healthy Sight Collada scene does not contain a renderable visual scene: ${url}`);
  }

  const object = new THREE.Group();
  for (const node of childrenByName(visualScene, "node")) {
    const instance = firstByName(node, "instance_geometry");
    if (!instance) {
      continue;
    }

    const geometryId = stripHash(instance.getAttribute("url"));
    const parts = geometries.get(geometryId) || [];
    const nodeGroup = new THREE.Group();

    for (const part of parts) {
      if (!part.positions.length) {
        continue;
      }

      const geometry = new THREE.BufferGeometry();
      geometry.setAttribute("position", new THREE.Float32BufferAttribute(part.positions, 3));
      if (part.uvs.length) {
        geometry.setAttribute("uv", new THREE.Float32BufferAttribute(part.uvs, 2));
      }
      if (part.normals.length === part.positions.length) {
        geometry.setAttribute("normal", new THREE.Float32BufferAttribute(part.normals, 3));
      } else {
        geometry.computeVertexNormals();
      }
      geometry.computeBoundingSphere();

      const texture = materialTextures.get(part.material);
      const material = new THREE.MeshBasicMaterial({
        map: texture || null,
        color: texture ? 0xffffff : 0x9fbdcf,
        side: THREE.DoubleSide,
        transparent: Boolean(texture && /png$/i.test(texture.image?.src || "")),
        depthWrite: false,
      });
      const mesh = new THREE.Mesh(geometry, material);
      mesh.frustumCulled = false;
      nodeGroup.add(mesh);
    }

    applyNodeTransform(node, nodeGroup);
    object.add(nodeGroup);
  }

  return object;
}

async function createSpritePlane(config, base, loadTexture) {
  const texture = await loadTexture(assetUrl(base, config.url));
  const material = new THREE.SpriteMaterial({
    map: texture,
    depthTest: false,
    transparent: true,
    depthWrite: false,
  });
  const sprite = new THREE.Sprite(material);
  sprite.position.copy(actionScriptToThree(config.position));
  sprite.scale.set(config.width * foregroundScale, config.height * foregroundScale, 1);
  sprite.renderOrder = config.renderOrder ?? 3;
  return sprite;
}

async function createKiteRig(base, loadTexture) {
  const texture = await loadTexture(assetUrl(base, "wireframes/Panorama_1/kite-swf.png?v=hsfl-kite-aa-1"));
  const material = new THREE.SpriteMaterial({
    map: texture,
    depthTest: false,
    transparent: true,
    depthWrite: false,
  });
  const sprite = new THREE.Sprite(material);
  const kiteHome = actionScriptToThree([-180, 345, 1450]);
  sprite.position.copy(kiteHome);
  sprite.scale.set(kiteImageSize.width * kiteScale, kiteImageSize.height * kiteScale, 1);
  sprite.renderOrder = 2;

  const stringPoints = new THREE.CatmullRomCurve3([
    actionScriptToThree([185, -420, 920]),
    actionScriptToThree([120, -275, 1030]),
    actionScriptToThree([20, -115, 1140]),
    actionScriptToThree([-60, 55, 1260]),
    actionScriptToThree([-130, 200, 1370]),
    actionScriptToThree([-175, 260, 1435]),
  ]).getPoints(30);
  const stringGeometry = new THREE.BufferGeometry().setFromPoints(stringPoints);
  const stringMaterial = new THREE.LineBasicMaterial({
    color: 0x1d679a,
    depthTest: false,
    depthWrite: false,
    opacity: 0.36,
    transparent: true,
  });
  const string = new THREE.Line(stringGeometry, stringMaterial);
  string.frustumCulled = false;
  string.renderOrder = 2;

  const rig = new THREE.Group();
  rig.add(string, sprite);
  rig.userData.animateKiteRig = {
    kiteHome,
    sprite,
    string,
    stringPoints,
  };
  return rig;
}

function setActiveButton(container, selector, valueAttribute, value) {
  for (const button of container.querySelectorAll(selector)) {
    button.classList.toggle("active", button.dataset[valueAttribute] === String(value));
  }
}

async function initPanorama(root, token) {
  const canvas = root.querySelector("[data-hsfl-canvas]");
  const loading = root.querySelector("[data-hsfl-loading]");
  const effectOverlay = root.querySelector("[data-hsfl-effect-overlay]");
  const sceneControls = root.querySelector("[data-hsfl-scenes]");
  const effectControls = root.querySelector("[data-hsfl-effects]");
  const kicker = root.querySelector("[data-hsfl-scene-kicker]");
  const title = root.querySelector("[data-hsfl-scene-title]");
  const assetBase = root.dataset.assetBase;
  const renderer = new THREE.WebGLRenderer({
    canvas,
    alpha: true,
    antialias: true,
    powerPreference: "high-performance",
  });
  const loadTexture = createTextureLoader(renderer);
  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(38, 16 / 9, 0.01, 100);
  const pointer = { x: 0.5, y: 0.5 };
  const current = { yaw: 0, pitch: 0, scene: 0, effect: "healthy" };
  const target = { yaw: 0, pitch: 0 };
  const loadedScenes = new Map();
  let currentGroup = null;
  let frameId = 0;
  let activeSceneToken = null;

  renderer.outputColorSpace = THREE.SRGBColorSpace;
  renderer.setClearColor(0x000000, 0);
  camera.rotation.order = "YXZ";

  const resize = () => {
    const rect = root.getBoundingClientRect();
    const width = Math.max(1, Math.round(rect.width));
    const height = Math.max(1, Math.round(rect.height));
    const pixelRatio = Math.min(window.devicePixelRatio || 1, 2);
    renderer.setPixelRatio(pixelRatio);
    renderer.setSize(width, height, false);
    camera.aspect = width / height;
    camera.updateProjectionMatrix();
  };

  const resizeObserver = new ResizeObserver(resize);
  resizeObserver.observe(root);
  resize();

  const wrapSceneIndex = (index) => (index + scenes.length) % scenes.length;

  const updateSceneButtons = (index) => {
    for (const button of sceneControls.querySelectorAll("[data-hsfl-scene-step]")) {
      const step = Number(button.dataset.hsflSceneStep || 0);
      const targetIndex = wrapSceneIndex(index + step);
      const label = button.querySelector("[data-hsfl-scene-button-label]");
      button.dataset.hsflScene = String(targetIndex);
      button.setAttribute("aria-label", `${step < 0 ? "Previous" : "Next"} scene: ${scenes[targetIndex].title}`);
      if (label) {
        label.textContent = scenes[targetIndex].title;
      }
    }
  };

  const updateEffectTabOrder = () => {
    const isOpen = effectControls.classList.contains("is-open");
    for (const button of effectControls.querySelectorAll("[data-hsfl-effect]")) {
      button.tabIndex = isOpen || button.classList.contains("active") ? 0 : -1;
    }
  };

  const setEffectMenuOpen = (isOpen) => {
    effectControls.classList.toggle("is-open", isOpen);
    effectControls.setAttribute("aria-expanded", String(isOpen));
    updateEffectTabOrder();
  };

  const loadScene = async (index) => {
    if (!loadedScenes.has(index)) {
      const config = scenes[index];
      const sceneDir = config.dae.split("/").slice(0, -1).join("/");
      const daeUrl = assetUrl(assetBase, config.dae);
      const daeBase = assetUrl(assetBase, `${sceneDir}/`);
      loadedScenes.set(
        index,
        (async () => {
          const group = new THREE.Group();
          const model = await loadColladaObject(daeUrl, daeBase, renderer, loadTexture);
          model.position.copy(actionScriptToThree(config.modelPosition || [0, 0, 0]));
          model.rotation.set(
            degToRad(config.modelRotation?.[0] || 0),
            degToRad(config.modelRotation?.[1] || 0),
            degToRad(config.modelRotation?.[2] || 0)
          );
          group.add(model);

          if (config.kite) {
            group.add(await createKiteRig(assetBase, loadTexture));
          }

          for (const foreground of config.foregrounds || []) {
            group.add(await createSpritePlane(foreground, assetBase, loadTexture));
          }

          return group;
        })()
      );
    }

    return loadedScenes.get(index);
  };

  const showScene = async (index) => {
    const sceneToken = Symbol("hsflScene");
    activeSceneToken = sceneToken;
    root.classList.add("hsfl-stage-loading-active");
    root.dataset.hsflScene = String(index);
    loading.textContent = "Loading scene";

    const config = scenes[index];
    kicker.textContent = `Scene ${index + 1} of ${scenes.length}`;
    title.textContent = config.title;
    updateSceneButtons(index);

    try {
      const group = await loadScene(index);
      if (root[initTokenKey] !== token || activeSceneToken !== sceneToken) {
        return;
      }

      if (currentGroup) {
        scene.remove(currentGroup);
      }
      currentGroup = group;
      scene.add(currentGroup);

      camera.fov = config.fov;
      camera.position.set(0, 0, config.cameraZ * worldScale);
      camera.updateProjectionMatrix();
      current.scene = index;
      current.yaw = 0;
      current.pitch = 0;
      target.yaw = 0;
      target.pitch = 0;
      root.classList.add("hsfl-stage-ready");
      root.classList.remove("hsfl-stage-loading-active", "hsfl-stage-error");
      loading.textContent = "";
    } catch (error) {
      root.classList.add("hsfl-stage-error");
      loading.textContent = "Scene failed to load";
      console.error("Healthy Sight panorama failed", error);
      throw error;
    }
  };

  const setEffect = (effect) => {
    current.effect = effect;
    root.dataset.hsflEffect = effect;
    effectOverlay.style.backgroundImage = effects[effect] ? `url("${assetUrl(assetBase, effects[effect])}")` : "";
    setActiveButton(effectControls, "button", "hsflEffect", effect);
    updateEffectTabOrder();
  };

  const updatePointer = (clientX, clientY) => {
    const rect = root.getBoundingClientRect();
    pointer.x = THREE.MathUtils.clamp((clientX - rect.left) / rect.width, 0, 1);
    pointer.y = THREE.MathUtils.clamp((clientY - rect.top) / rect.height, 0, 1);
    root.style.setProperty("--hsfl-pointer-x", `${(pointer.x * 100).toFixed(2)}%`);
    root.style.setProperty("--hsfl-pointer-y", `${(pointer.y * 100).toFixed(2)}%`);
  };

  const onPointerMove = (event) => {
    updatePointer(event.clientX, event.clientY);
  };

  const onSceneClick = (event) => {
    const button = event.target.closest("[data-hsfl-scene], [data-hsfl-scene-step]");
    if (button) {
      showScene(Number(button.dataset.hsflScene));
    }
  };

  const onEffectClick = (event) => {
    const button = event.target.closest("[data-hsfl-effect]");
    if (!button) {
      return;
    }

    event.stopPropagation();
    if (!effectControls.classList.contains("is-open")) {
      setEffectMenuOpen(true);
      return;
    }

    setEffect(button.dataset.hsflEffect);
    setEffectMenuOpen(false);
  };

  const onEffectKeyDown = (event) => {
    if (event.key === "Escape") {
      setEffectMenuOpen(false);
    }
  };

  const onDocumentPointerDown = (event) => {
    if (!effectControls.contains(event.target)) {
      setEffectMenuOpen(false);
    }
  };

  root.addEventListener("pointermove", onPointerMove);
  sceneControls.addEventListener("click", onSceneClick);
  effectControls.addEventListener("click", onEffectClick);
  effectControls.addEventListener("keydown", onEffectKeyDown);
  document.addEventListener("pointerdown", onDocumentPointerDown);

  const render = (time) => {
    const config = scenes[current.scene];
    const centerWeight = Math.cos(Math.abs(pointer.x - 0.5) * Math.PI) * 0.38 + 1;
    const yawMin = config.yawMin ?? (config.yawLimit ? -config.yawLimit : config.xRange * -0.5);
    const yawMax = config.yawMax ?? (config.yawLimit || config.xRange * 0.5);
    const pitchMin = config.pitchMin ?? -(config.pitchLimit || config.yRange);
    const pitchMax = config.pitchMax ?? (config.pitchLimit || config.yRange);
    const rawYaw = pointer.x < 0.5
      ? (0.5 - pointer.x) * yawMin * 2 * centerWeight
      : (pointer.x - 0.5) * yawMax * 2 * centerWeight;
    const rawPitch = pointer.y < 0.5
      ? (0.5 - pointer.y) * pitchMax * 2
      : (pointer.y - 0.5) * pitchMin * 2;
    target.yaw = THREE.MathUtils.clamp(rawYaw, yawMin, yawMax);
    target.pitch = THREE.MathUtils.clamp(rawPitch, pitchMin, pitchMax);
    current.yaw += (target.yaw - current.yaw) * 0.09;
    current.pitch += (target.pitch - current.pitch) * 0.11;

    camera.rotation.x = degToRad(current.pitch);
    camera.rotation.y = Math.PI + degToRad(current.yaw);

    if (currentGroup) {
      currentGroup.traverse((object) => {
        const rig = object.userData.animateKiteRig;
        if (!rig) {
          return;
        }

        const swayX = Math.sin(time * 0.0009) * 0.018;
        const swayY = Math.sin(time * 0.0016) * 0.024;
        const swayZ = Math.sin(time * 0.0007) * 0.012;
        rig.sprite.position.set(rig.kiteHome.x + swayX, rig.kiteHome.y + swayY, rig.kiteHome.z + swayZ);

        const positions = rig.string.geometry.attributes.position;
        const maxIndex = Math.max(1, rig.stringPoints.length - 1);
        for (let index = 0; index < rig.stringPoints.length; index += 1) {
          const point = rig.stringPoints[index];
          const t = index / maxIndex;
          const ripple = Math.sin(time * 0.002 + t * 8) * 0.005 * t;
          positions.setXYZ(
            index,
            point.x + swayX * t + ripple,
            point.y + swayY * t + Math.sin(time * 0.0014 + t * 5) * 0.004 * t,
            point.z + swayZ * t
          );
        }
        positions.needsUpdate = true;
        rig.string.geometry.computeBoundingSphere();
      });
    }

    renderer.render(scene, camera);
    frameId = requestAnimationFrame(render);
  };

  await showScene(0);
  setEffect("healthy");
  setEffectMenuOpen(false);
  frameId = requestAnimationFrame(render);

  return () => {
    cancelAnimationFrame(frameId);
    resizeObserver.disconnect();
    root.removeEventListener("pointermove", onPointerMove);
    sceneControls.removeEventListener("click", onSceneClick);
    effectControls.removeEventListener("click", onEffectClick);
    effectControls.removeEventListener("keydown", onEffectKeyDown);
    document.removeEventListener("pointerdown", onDocumentPointerDown);
    renderer.dispose();
  };
}

for (const root of roots) {
  cleanupRoot(root);
  const initToken = Symbol("healthySightPanoramaInit");
  root[initTokenKey] = initToken;

  initPanorama(root, initToken)
    .then((cleanup) => {
      if (root[initTokenKey] === initToken) {
        root[cleanupKey] = cleanup;
      } else if (cleanup) {
        cleanup();
      }
    })
    .catch((error) => {
      console.error("Healthy Sight panorama initialization failed", error);
    });
}
