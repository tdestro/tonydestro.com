import * as THREE from "/static/vendor/three.module.min.js";

const canvas = document.querySelector("[data-archive-scene]");

if (canvas) {
  const hero = canvas.closest(".hero-home");
  const frameImages = Array.from(hero.querySelectorAll(".hero-frame img"));
  const imageSources = frameImages.map((image) => image.currentSrc || image.src).filter(Boolean);

  if (imageSources.length > 0) {
    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(40, 1, 0.1, 100);
    const renderer = new THREE.WebGLRenderer({
      alpha: true,
      antialias: true,
      canvas,
      powerPreference: "high-performance",
    });
    const root = new THREE.Group();
    const panels = new THREE.Group();
    const rails = new THREE.Group();
    const clock = new THREE.Clock();
    const pointer = { x: 0, y: 0 };
    const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

    camera.position.set(0, 0, 13.5);
    scene.add(root);
    root.add(rails, panels);

    renderer.setClearColor(0x000000, 0);
    renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 1.75));
    renderer.outputColorSpace = THREE.SRGBColorSpace;

    const loader = new THREE.TextureLoader();
    const panelSpecs = [
      { x: 3.25, y: 1.38, z: -1.0, width: 4.5, height: 2.58, ry: -0.34, rz: 0.012 },
      { x: 1.08, y: -0.36, z: 0.22, width: 2.05, height: 2.82, ry: -0.16, rz: -0.012 },
      { x: 5.18, y: -0.78, z: 0.54, width: 1.78, height: 3.28, ry: -0.42, rz: 0.015 },
      { x: 4.22, y: 2.58, z: -0.2, width: 3.62, height: 0.72, ry: -0.2, rz: -0.008 },
      { x: 2.82, y: -2.08, z: 0.45, width: 3.42, height: 1.92, ry: -0.28, rz: 0.016 },
      { x: 5.68, y: 0.58, z: -0.36, width: 2.42, height: 1.56, ry: -0.38, rz: 0.018 },
    ];

    const frameMaterial = new THREE.LineBasicMaterial({
      color: 0xd6aa58,
      opacity: 0.42,
      transparent: true,
    });
    const redLineMaterial = new THREE.LineBasicMaterial({
      color: 0xff2b1f,
      opacity: 0.5,
      transparent: true,
    });
    const railMaterial = new THREE.LineBasicMaterial({
      color: 0xf4efe6,
      opacity: 0.18,
      transparent: true,
    });
    const nodeMaterial = new THREE.PointsMaterial({
      color: 0xd6aa58,
      opacity: 0.74,
      size: 0.055,
      transparent: true,
    });

    function makeLine(points, material) {
      const geometry = new THREE.BufferGeometry().setFromPoints(points);
      return new THREE.Line(geometry, material);
    }

    function cropTextureToPanel(texture, spec) {
      if (!texture.image?.width || !texture.image?.height) {
        return;
      }

      const imageAspect = texture.image.width / texture.image.height;
      const panelAspect = spec.width / spec.height;
      texture.wrapS = THREE.ClampToEdgeWrapping;
      texture.wrapT = THREE.ClampToEdgeWrapping;
      texture.repeat.set(1, 1);
      texture.offset.set(0, 0);

      if (imageAspect > panelAspect) {
        texture.repeat.x = panelAspect / imageAspect;
        texture.offset.x = (1 - texture.repeat.x) / 2;
      } else {
        texture.repeat.y = imageAspect / panelAspect;
        texture.offset.y = (1 - texture.repeat.y) / 2;
      }

      texture.needsUpdate = true;
    }

    function addPanel(src, spec, index) {
      const group = new THREE.Group();
      group.position.set(spec.x, spec.y, spec.z);
      group.rotation.set(-0.03, spec.ry, spec.rz);
      group.userData.homeY = spec.y;
      group.userData.phase = index * 0.8;

      const texture = loader.load(src, () => {
        texture.colorSpace = THREE.SRGBColorSpace;
        texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
        cropTextureToPanel(texture, spec);
      });
      texture.colorSpace = THREE.SRGBColorSpace;

      const imageMaterial = new THREE.MeshBasicMaterial({
        color: 0xffffff,
        map: texture,
        opacity: 0.64,
        transparent: true,
      });
      const plane = new THREE.Mesh(new THREE.PlaneGeometry(spec.width, spec.height), imageMaterial);
      group.add(plane);

      const frameGeometry = new THREE.EdgesGeometry(new THREE.BoxGeometry(spec.width, spec.height, 0.05));
      const frame = new THREE.LineSegments(frameGeometry, frameMaterial);
      frame.position.z = 0.035;
      group.add(frame);

      const inspectionLine = makeLine(
        [
          new THREE.Vector3(-spec.width * 0.42, spec.height * 0.42, 0.08),
          new THREE.Vector3(spec.width * 0.42, spec.height * 0.42, 0.08),
        ],
        index % 2 === 0 ? redLineMaterial : frameMaterial,
      );
      group.add(inspectionLine);

      panels.add(group);
      return group;
    }

    imageSources.slice(0, panelSpecs.length).forEach((src, index) => addPanel(src, panelSpecs[index], index));

    const railPositions = [];
    for (let row = 0; row < 7; row += 1) {
      const y = 2.8 - row * 0.8;
      railPositions.push(-1.5, y, -1.7, 6.6, y, -1.7);
    }
    for (let column = 0; column < 9; column += 1) {
      const x = -1.2 + column * 0.95;
      railPositions.push(x, 3.05, -1.72, x, -2.25, -1.72);
    }
    const railGeometry = new THREE.BufferGeometry();
    railGeometry.setAttribute("position", new THREE.Float32BufferAttribute(railPositions, 3));
    rails.add(new THREE.LineSegments(railGeometry, railMaterial));

    const connectorPositions = [];
    for (let i = 0; i < panelSpecs.length - 1; i += 1) {
      const a = panelSpecs[i];
      const b = panelSpecs[i + 1];
      connectorPositions.push(a.x, a.y, a.z + 0.12, b.x, b.y, b.z + 0.12);
    }
    connectorPositions.push(-0.8, -1.9, -0.9, 5.9, 2.4, -0.9);
    connectorPositions.push(-0.5, 2.5, -1.2, 6.2, -1.7, -1.2);
    const connectorGeometry = new THREE.BufferGeometry();
    connectorGeometry.setAttribute("position", new THREE.Float32BufferAttribute(connectorPositions, 3));
    rails.add(new THREE.LineSegments(connectorGeometry, redLineMaterial));

    const nodePositions = [];
    panelSpecs.forEach((spec) => {
      nodePositions.push(spec.x, spec.y, spec.z + 0.2);
      nodePositions.push(spec.x - spec.width * 0.46, spec.y + spec.height * 0.44, spec.z + 0.14);
      nodePositions.push(spec.x + spec.width * 0.46, spec.y - spec.height * 0.44, spec.z + 0.14);
    });
    const nodeGeometry = new THREE.BufferGeometry();
    nodeGeometry.setAttribute("position", new THREE.Float32BufferAttribute(nodePositions, 3));
    rails.add(new THREE.Points(nodeGeometry, nodeMaterial));

    const tickPositions = [];
    for (let i = 0; i < 34; i += 1) {
      const x = -1.35 + i * 0.24;
      const tall = i % 5 === 0;
      tickPositions.push(x, -2.72, 0.2, x, -2.72 + (tall ? 0.28 : 0.14), 0.2);
    }
    const tickGeometry = new THREE.BufferGeometry();
    tickGeometry.setAttribute("position", new THREE.Float32BufferAttribute(tickPositions, 3));
    rails.add(new THREE.LineSegments(tickGeometry, railMaterial));

    function resize() {
      const rect = hero.getBoundingClientRect();
      const width = Math.max(1, Math.floor(rect.width));
      const height = Math.max(1, Math.floor(rect.height));
      renderer.setSize(width, height, false);
      camera.aspect = width / height;
      camera.updateProjectionMatrix();

      const narrow = width < 760;
      root.position.set(narrow ? 1.55 : 1.05, narrow ? 1.35 : 0.0, 0);
      root.scale.setScalar(narrow ? 0.54 : 0.88);
    }

    function animate() {
      const t = clock.getElapsedTime();

      if (!reducedMotion) {
        root.rotation.y = -0.07 + pointer.x * 0.08 + Math.sin(t * 0.22) * 0.018;
        root.rotation.x = pointer.y * -0.035;
        panels.children.forEach((panel) => {
          panel.position.y = panel.userData.homeY + Math.sin(t * 0.8 + panel.userData.phase) * 0.035;
        });
      }

      renderer.render(scene, camera);
      window.requestAnimationFrame(animate);
    }

    hero.addEventListener("pointermove", (event) => {
      const rect = hero.getBoundingClientRect();
      pointer.x = ((event.clientX - rect.left) / rect.width - 0.5) * 2;
      pointer.y = ((event.clientY - rect.top) / rect.height - 0.5) * 2;
    });

    document.documentElement.classList.add("webgl-archive-ready");
    resize();
    animate();
    window.addEventListener("resize", resize);
  }
}
