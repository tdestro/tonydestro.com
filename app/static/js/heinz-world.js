import * as THREE from "/static/vendor/three.module.min.js";

const roots = document.querySelectorAll("[data-heinz-world]");
const cleanupKey = "__heinzWorldCleanup";
const initTokenKey = "__heinzWorldInitToken";

function cleanupRoot(root) {
  if (typeof root[cleanupKey] === "function") {
    root[cleanupKey]();
    root[cleanupKey] = undefined;
  }
  root[initTokenKey] = undefined;
}

const panelCopy = {
  breakfast: [
    "Breakfast with the Mason family includes Ore-Ida hash browns",
    "The Stewart family enjoy Lea & Perrins with their steak and eggs",
    "Three generations of Baldwins choose Ore-Ida roasted potatoes.",
    "The Jacksons choose Heinz for their beans on toast",
    "The Jansens include De Ruijter sprinkles on their toast",
    "Rebecca starts her son's morning with Buckwheat baby food",
    "Jai's daughter begins her day with Shi instant baby food",
    "The Collins wake up to a plate of Watties Toasties",
  ],
  lunch: [
    "Jonelle and her friends share Smart Ones Anytime Selections",
    "James makes Boston Market frozen entrees for his lunch",
    "Sandra and Janie include a bowl of Chef Francisco soup with their lunch",
    "The Teixeiras complete their pasta lunch with Orlando sauce",
    "The Spelmans include Honig soup with lunch",
    "The Chernek family complete their lunch with Moya Semya",
    "Dien and Kade include ABC sauce with their lunch",
    "Aaiden enjoys Big Eat meals for lunch",
  ],
  dinner: [
    "The Coopers select Classico with their dinner",
    "The Cruz family make Delimex their dinner",
    "Heinz is a staple in the Matthews household",
    "The Ashfords prepare their dinner salads with Heinz",
    "The Kowalskis include Pudliszki with their dinner",
    "The Pillai children enjoy a glass of Complan",
    "Long Fong is a staple in the Jiang household",
    "The Hyuns choose Heinz yellow mustard with their dinner",
  ],
  snack: [
    "Katie tops her salads with Renees dressing",
    "David's late night snacks include Bagel Bites",
    "Johann gives his son Nenerina baby foods",
    "Eadan's snack of choice is Heinz sponge pudding",
    "Alessa provides her baby with Plasmon snacks",
    "Manoj enjoys the afternoon energy boost of Glucon-D",
    "The Tsengs share a Long Fong snack",
    "The Kobayashis complete their meal with Demi Glace sauce",
  ],
};

const mealLabels = {
  breakfast: "Breakfast",
  lunch: "Lunch",
  dinner: "Dinner",
  snack: "Snack",
};

const logoByMealZone = {
  "breakfast:0": "1",
  "breakfast:1": "3",
  "breakfast:2": "1",
  "breakfast:3": "5",
  "breakfast:4": "7",
  "breakfast:5": "5",
  "breakfast:6": "5",
  "breakfast:7": "9",
  "lunch:0": "11",
  "lunch:1": "13",
  "lunch:2": "15",
  "lunch:3": "17",
  "lunch:4": "19",
  "lunch:5": "21",
  "lunch:6": "23",
  "lunch:7": "5",
  "dinner:0": "25",
  "dinner:1": "27",
  "dinner:2": "5",
  "dinner:3": "5",
  "dinner:4": "29",
  "dinner:5": "31",
  "dinner:6": "5",
  "dinner:7": "5",
  "snack:0": "33",
  "snack:1": "35",
  "snack:2": "37",
  "snack:3": "37",
  "snack:4": "39",
  "snack:5": "41",
  "snack:6": "5",
  "snack:7": "5",
};

const easeInOut = (value) =>
  value < 0.5 ? 4 * Math.pow(value, 3) : 1 - Math.pow(-2 * value + 2, 3) / 2;
const xAxis = new THREE.Vector3(1, 0, 0);
const yAxis = new THREE.Vector3(0, 1, 0);
const zAxis = new THREE.Vector3(0, 0, 1);
const globeAxisTilt = THREE.MathUtils.degToRad(-23.44);
const worldPitchTilt = THREE.MathUtils.degToRad(-17);
const halfTurnTieThreshold = Math.PI / 180;
const shortestRotationDistance = (from, to, lastDirection) => {
  const distance = Math.atan2(Math.sin(to - from), Math.cos(to - from));
  return Math.abs(Math.abs(distance) - Math.PI) < halfTurnTieThreshold
    ? Math.PI * lastDirection
    : distance;
};
const moonOrbit = {
  distance: 3.9,
  inclination: THREE.MathUtils.degToRad(5.14),
};
const eclipticPlate = {
  opacity: 0.2,
  width: 20.5,
  depth: 13.5,
};
const asteroidBelt = {
  asteroidCount: 82,
  asteroidOpacity: 0.46,
  asteroidSize: 0.032,
  dustCount: 420,
  dustOpacity: 0.2,
  dustSize: 0.014,
  innerRadius: 5.7,
  outerRadius: 10.4,
  rotationSpeed: 0.000025,
  thickness: 0.44,
};
const atmosphericStorms = {
  count: 10,
  flashPeriodMin: 14000,
  flashPeriodRange: 26000,
  flashStrengthMin: 0.62,
  flashStrengthRange: 0.5,
  lightningRadius: 1.868,
  radius: 1.858,
  rotationDrift: 0.000018,
};
const issOrbit = {
  inclination: THREE.MathUtils.degToRad(51.64),
  opacity: 0.58,
  period: 52000,
  phase: 0.18,
  radius: 2.08,
};
const rocketMission = {
  activeWindow: 0.38,
  lunarOrbitRadius: 0.52,
  marsOrbitRadius: 0.42,
  orbitRadius: 2.78,
  opacity: 0.84,
  parkingOrbitTurns: 0.24,
  period: 210000,
  phase: 0.72,
  surfaceRadius: 1.93,
  sweep: THREE.MathUtils.degToRad(118),
  transferLift: 0.42,
};
const rocketMissionProfiles = [
  {
    target: "moon",
    segments: [
      { end: 0.3, mode: "launch", start: 0 },
      { end: 0.44, mode: "earthOrbit", start: 0.3 },
      { end: 0.86, mode: "moonTransfer", start: 0.44 },
      { end: 1, mode: "moonOrbit", start: 0.86 },
    ],
  },
  {
    target: "mars",
    segments: [
      { end: 0.28, mode: "launch", start: 0 },
      { end: 0.42, mode: "earthOrbit", start: 0.28 },
      { end: 0.88, mode: "marsTransfer", start: 0.42 },
      { end: 1, mode: "marsOrbit", start: 0.88 },
    ],
  },
];
const rocketLaunchSites = [
  { name: "Kennedy LC-39A", latitude: 28.6084, longitude: -80.6043, azimuth: 82 },
  { name: "Cape Canaveral SLC-40", latitude: 28.5619, longitude: -80.5772, azimuth: 82 },
  { name: "Vandenberg SLC-4E", latitude: 34.6321, longitude: -120.6106, azimuth: 170 },
  { name: "Starbase Boca Chica", latitude: 25.9971, longitude: -97.1569, azimuth: 94 },
  { name: "Guiana Space Centre", latitude: 5.239, longitude: -52.768, azimuth: 90 },
  { name: "Baikonur Site 31", latitude: 45.996, longitude: 63.564, azimuth: 64 },
  { name: "Tanegashima Yoshinobu", latitude: 30.4008, longitude: 130.9759, azimuth: 95 },
  { name: "Satish Dhawan Space Centre", latitude: 13.7199, longitude: 80.2304, azimuth: 100 },
  { name: "Wenchang Space Launch Site", latitude: 19.6145, longitude: 110.951, azimuth: 100 },
  { name: "Rocket Lab LC-1 Mahia", latitude: -39.2628, longitude: 177.8645, azimuth: 130 },
  { name: "Jiuquan Satellite Launch Center", latitude: 40.958, longitude: 100.291, azimuth: 97 },
  { name: "Plesetsk Cosmodrome", latitude: 62.9256, longitude: 40.5778, azimuth: 350 },
];
const rocketLandingSites = [
  { name: "Kennedy Shuttle Landing Facility", latitude: 28.5865, longitude: -80.6508, azimuth: 95 },
  { name: "Cape Canaveral Landing Zone 1", latitude: 28.4858, longitude: -80.5452, azimuth: 82 },
  { name: "Edwards Air Force Base", latitude: 34.9054, longitude: -117.8837, azimuth: 78 },
  { name: "White Sands Space Harbor", latitude: 32.9407, longitude: -106.4198, azimuth: 70 },
  { name: "Starbase Boca Chica Pad", latitude: 25.9971, longitude: -97.1569, azimuth: 94 },
  { name: "Vandenberg Landing Zone", latitude: 34.6321, longitude: -120.6106, azimuth: 170 },
  { name: "Siziwang Banner Landing Site", latitude: 41.533, longitude: 111.68, azimuth: 92 },
  { name: "Dongfeng Landing Site", latitude: 41.1, longitude: 100.3, azimuth: 88 },
  { name: "Baikonur Steppe Recovery Zone", latitude: 47.0, longitude: 69.0, azimuth: 64 },
];
const visibleComets = [
  {
    arc: THREE.MathUtils.degToRad(76),
    angle: THREE.MathUtils.degToRad(204),
    distance: 8.6,
    incline: 1.15,
    length: 2.4,
    opacity: 0.9,
    period: 43000,
    phase: 0.03,
    width: 0.34,
    window: 0.34,
  },
  {
    arc: THREE.MathUtils.degToRad(54),
    angle: THREE.MathUtils.degToRad(318),
    distance: 7.2,
    incline: -0.72,
    length: 1.85,
    opacity: 0.68,
    period: 71000,
    phase: 0.61,
    width: 0.26,
    window: 0.24,
  },
  {
    arc: THREE.MathUtils.degToRad(118),
    angle: THREE.MathUtils.degToRad(128),
    distance: 9.3,
    incline: 0.48,
    length: 2.95,
    opacity: 0.78,
    period: 97000,
    phase: 0.79,
    width: 0.3,
    window: 0.28,
  },
];
const tileIdleMotion = {
  depth: 0.018,
  lift: 0.022,
  pitch: THREE.MathUtils.degToRad(0.42),
  resumeDelay: 470,
  resumeDuration: 680,
  speed: 0.00105,
};
const celestialClock = {
  earthScale: 720,
  moonScale: 7200,
  planetScale: 7200,
};
const planetScene = {
  baseDepth: -5.7,
  baseHeight: 1.08,
  distanceBase: 5.9,
  distanceMax: 9.4,
  distanceSpread: 1.65,
  eclipticDepth: 0.18,
  eclipticLift: 0.08,
  inclinationLift: 1.35,
};
const orbitalElements = {
  mercury: {
    base: { a: 0.38709927, e: 0.20563593, i: 7.00497902, l: 252.2503235, p: 77.45779628, n: 48.33076593 },
    rate: { a: 0.00000037, e: 0.00001906, i: -0.00594749, l: 149472.67411175, p: 0.16047689, n: -0.12534081 },
  },
  venus: {
    base: { a: 0.72333566, e: 0.00677672, i: 3.39467605, l: 181.9790995, p: 131.60246718, n: 76.67984255 },
    rate: { a: 0.0000039, e: -0.00004107, i: -0.0007889, l: 58517.81538729, p: 0.00268329, n: -0.27769418 },
  },
  earth: {
    base: { a: 1.00000261, e: 0.01671123, i: -0.00001531, l: 100.46457166, p: 102.93768193, n: 0 },
    rate: { a: 0.00000562, e: -0.00004392, i: -0.01294668, l: 35999.37244981, p: 0.32327364, n: 0 },
  },
  mars: {
    base: { a: 1.52371034, e: 0.0933941, i: 1.84969142, l: -4.55343205, p: -23.94362959, n: 49.55953891 },
    rate: { a: 0.00001847, e: 0.00007882, i: -0.00813131, l: 19140.30268499, p: 0.44441088, n: -0.29257343 },
  },
  jupiter: {
    base: { a: 5.202887, e: 0.04838624, i: 1.30439695, l: 34.39644051, p: 14.72847983, n: 100.47390909 },
    rate: { a: -0.00011607, e: -0.00013253, i: -0.00183714, l: 3034.74612775, p: 0.21252668, n: 0.20469106 },
  },
  saturn: {
    base: { a: 9.53667594, e: 0.05386179, i: 2.48599187, l: 49.95424423, p: 92.59887831, n: 113.66242448 },
    rate: { a: -0.0012506, e: -0.00050991, i: 0.00193609, l: 1222.49362201, p: -0.41897216, n: -0.28867794 },
  },
  uranus: {
    base: { a: 19.18916464, e: 0.04725744, i: 0.77263783, l: 313.23810451, p: 170.9542763, n: 74.01692503 },
    rate: { a: -0.00196176, e: -0.00004397, i: -0.00242939, l: 428.48202785, p: 0.40805281, n: 0.04240589 },
  },
  neptune: {
    base: { a: 30.06992276, e: 0.00859048, i: 1.77004347, l: -55.12002969, p: 44.96476227, n: 131.78422574 },
    rate: { a: 0.00026291, e: 0.00005105, i: 0.00035372, l: 218.45945325, p: -0.32241464, n: -0.00508664 },
  },
};
const visiblePlanets = [
  { base: "#8f8b82", color: 0x8f8b82, name: "Mercury", opacity: 0.74, radius: 0.064, target: "mercury" },
  { base: "#d9c18e", color: 0xd9c18e, name: "Venus", opacity: 0.78, radius: 0.088, target: "venus" },
  { base: "#b85e43", color: 0xb85e43, name: "Mars", opacity: 0.82, radius: 0.078, target: "mars" },
  { base: "#c9ad83", color: 0xc9ad83, name: "Jupiter", opacity: 0.84, radius: 0.2, stripes: ["#dec79c", "#a47652", "#ead8b5", "#8f6349"], target: "jupiter" },
  { base: "#d1bc84", color: 0xd1bc84, name: "Saturn", opacity: 0.8, radius: 0.17, ring: true, stripes: ["#d9ca9b", "#b99d63", "#eadfb7"], target: "saturn" },
  { base: "#8ccbd0", color: 0x8ccbd0, name: "Uranus", opacity: 0.7, radius: 0.112, target: "uranus" },
  { base: "#375eb2", color: 0x375eb2, name: "Neptune", opacity: 0.72, radius: 0.116, target: "neptune" },
];
const rotationDuration = (angle) => Math.max(360, (Math.abs(angle) / Math.PI) * 1400);
const logoPath = (meal, zone) =>
  `/static/images/archive/heinz-worldcarousel/logos/${logoByMealZone[`${meal}:${zone}`] || "5"}.png`;

function normalizeDegrees(degrees) {
  return ((degrees % 360) + 360) % 360;
}

function fract(value) {
  return value - Math.floor(value);
}

function seededUnit(seed) {
  return fract(Math.sin(seed * 12.9898) * 43758.5453);
}

function daysSinceJ2000(time) {
  return time / 86400000 + 2440587.5 - 2451545;
}

function earthRotationAt(time) {
  const days = daysSinceJ2000(time);
  return THREE.MathUtils.degToRad(normalizeDegrees(280.46061837 + 360.98564736629 * days));
}

function localNightFactor(time) {
  const date = new Date(time);
  const hours =
    date.getHours() + date.getMinutes() / 60 + date.getSeconds() / 3600 + date.getMilliseconds() / 3600000;
  const night = 1 - Math.cos(((hours - 12) / 24) * Math.PI * 2);
  return THREE.MathUtils.smoothstep(night / 2, 0.36, 0.88);
}

function moonLongitudeAt(time) {
  const days = daysSinceJ2000(time);
  return THREE.MathUtils.degToRad(normalizeDegrees(218.3164477 + 13.17639648 * days));
}

function moonNodeAt(time) {
  const days = daysSinceJ2000(time);
  return THREE.MathUtils.degToRad(normalizeDegrees(125.04452 - 0.0529538083 * days));
}

function moonArgumentAt(time) {
  return normalizeRadians(moonLongitudeAt(time) - moonNodeAt(time));
}

function normalizeRadians(radians) {
  return ((radians % (Math.PI * 2)) + Math.PI * 2) % (Math.PI * 2);
}

function solveKepler(meanAnomaly, eccentricity) {
  let eccentricAnomaly = meanAnomaly;
  for (let index = 0; index < 8; index += 1) {
    eccentricAnomaly -=
      (eccentricAnomaly - eccentricity * Math.sin(eccentricAnomaly) - meanAnomaly) /
      (1 - eccentricity * Math.cos(eccentricAnomaly));
  }
  return eccentricAnomaly;
}

function elementAt(definition, key, centuries) {
  return definition.base[key] + definition.rate[key] * centuries;
}

function heliocentricPlanetPosition(target, time) {
  const definition = orbitalElements[target];
  const centuries = daysSinceJ2000(time) / 36525;
  const a = elementAt(definition, "a", centuries);
  const e = elementAt(definition, "e", centuries);
  const i = THREE.MathUtils.degToRad(elementAt(definition, "i", centuries));
  const l = THREE.MathUtils.degToRad(normalizeDegrees(elementAt(definition, "l", centuries)));
  const p = THREE.MathUtils.degToRad(normalizeDegrees(elementAt(definition, "p", centuries)));
  const n = THREE.MathUtils.degToRad(normalizeDegrees(elementAt(definition, "n", centuries)));
  const meanAnomaly = normalizeRadians(l - p);
  const perihelionArgument = p - n;
  const eccentricAnomaly = solveKepler(meanAnomaly, e);
  const orbitalX = a * (Math.cos(eccentricAnomaly) - e);
  const orbitalY = a * Math.sqrt(1 - e * e) * Math.sin(eccentricAnomaly);
  const cosNode = Math.cos(n);
  const sinNode = Math.sin(n);
  const cosInclination = Math.cos(i);
  const sinInclination = Math.sin(i);
  const cosPerihelion = Math.cos(perihelionArgument);
  const sinPerihelion = Math.sin(perihelionArgument);

  return new THREE.Vector3(
    (cosNode * cosPerihelion - sinNode * sinPerihelion * cosInclination) * orbitalX +
      (-cosNode * sinPerihelion - sinNode * cosPerihelion * cosInclination) * orbitalY,
    (sinNode * cosPerihelion + cosNode * sinPerihelion * cosInclination) * orbitalX +
      (-sinNode * sinPerihelion + cosNode * cosPerihelion * cosInclination) * orbitalY,
    sinPerihelion * sinInclination * orbitalX + cosPerihelion * sinInclination * orbitalY
  );
}

function planetScenePosition(planetPosition, earthPosition) {
  const relative = planetPosition.clone().sub(earthPosition);
  const distanceAu = relative.length();
  const direction = relative.normalize();
  const distance = THREE.MathUtils.clamp(
    planetScene.distanceBase + Math.log1p(distanceAu) * planetScene.distanceSpread,
    planetScene.distanceBase,
    planetScene.distanceMax
  );

  return new THREE.Vector3(
    direction.x * distance,
    planetScene.baseHeight + direction.y * distance * planetScene.eclipticLift + direction.z * distance * planetScene.inclinationLift,
    planetScene.baseDepth + direction.y * distance * planetScene.eclipticDepth
  );
}

function cometScenePosition(comet, pass) {
  const centered = pass - 0.5;
  const sweep = centered * comet.arc;
  const distance = comet.distance - Math.cos(centered * Math.PI) * 1.15;
  const angle = comet.angle + sweep;
  const eclipticY = Math.sin(angle) * distance;

  return new THREE.Vector3(
    Math.cos(angle) * distance,
    planetScene.baseHeight +
      eclipticY * planetScene.eclipticLift +
      Math.sin(pass * Math.PI) * comet.incline,
    planetScene.baseDepth + eclipticY * planetScene.eclipticDepth - Math.cos(pass * Math.PI * 2) * 0.34
  );
}

function cometPass(comet, nowFrame, startFrame) {
  const cycle = fract((nowFrame - startFrame) / comet.period + comet.phase);
  if (cycle > comet.window) {
    return undefined;
  }

  const pass = cycle / comet.window;
  const fadeIn = THREE.MathUtils.smoothstep(pass, 0, 0.16);
  const fadeOut = THREE.MathUtils.smoothstep(1 - pass, 0, 0.2);
  return {
    brightness: fadeIn * fadeOut * (0.58 + Math.sin(pass * Math.PI) * 0.42),
    pass,
  };
}

function eclipticParticlePosition(angle, radius, offset) {
  const eclipticY = Math.sin(angle) * radius;

  return new THREE.Vector3(
    Math.cos(angle) * radius,
    planetScene.baseHeight + eclipticY * planetScene.eclipticLift + offset,
    planetScene.baseDepth + eclipticY * planetScene.eclipticDepth
  );
}

function eclipticParticleGeometry(count, bright) {
  const positions = new Float32Array(count * 3);
  const colors = new Float32Array(count * 3);

  for (let index = 0; index < count; index += 1) {
    const spread = fract(Math.sin(index * 17.731 + (bright ? 8.3 : 0)) * 67341.127);
    const angle =
      Math.PI * 2 * fract(Math.sin(index * 51.191 + (bright ? 2.9 : 0)) * 37117.519) +
      (bright ? 0.08 : 0);
    const radius =
      asteroidBelt.innerRadius +
      Math.pow(spread, bright ? 0.72 : 1.35) * (asteroidBelt.outerRadius - asteroidBelt.innerRadius);
    const offset =
      (fract(Math.sin(index * 91.73 + (bright ? 6.7 : 0)) * 23591.83) - 0.5) *
      asteroidBelt.thickness *
      (bright ? 1.2 : 0.82);
    const position = eclipticParticlePosition(angle, radius, offset);
    const positionIndex = index * 3;
    const colorMix = fract(Math.sin(index * 31.47 + 1.2) * 19317.91);
    const brightness = bright
      ? 0.48 + fract(Math.sin(index * 13.91) * 71827.2) * 0.44
      : 0.22 + fract(Math.sin(index * 11.41) * 27119.8) * 0.24;

    positions[positionIndex] = position.x;
    positions[positionIndex + 1] = position.y;
    positions[positionIndex + 2] = position.z;
    colors[positionIndex] = brightness * (bright ? 1 : 0.72);
    colors[positionIndex + 1] = brightness * (0.76 + colorMix * 0.18);
    colors[positionIndex + 2] = brightness * (bright ? 0.48 + colorMix * 0.16 : 0.82);
  }

  const geometry = new THREE.BufferGeometry();
  geometry.setAttribute("position", new THREE.BufferAttribute(positions, 3));
  geometry.setAttribute("color", new THREE.BufferAttribute(colors, 3));
  return geometry;
}

function rocketFlightState(nowFrame, startFrame, startTime) {
  const missionClock = startTime + (nowFrame - startFrame);
  const rawCycle = missionClock / rocketMission.period + rocketMission.phase;
  const cycleProgress = fract(rawCycle);

  if (cycleProgress > rocketMission.activeWindow) {
    return undefined;
  }

  const missionProgress = cycleProgress / rocketMission.activeWindow;
  const missionIndex = Math.max(0, Math.floor(rawCycle));
  const missionStartFrame =
    startFrame + ((missionIndex - rocketMission.phase) * rocketMission.period - startTime);
  const profile = rocketMissionProfiles[missionIndex % rocketMissionProfiles.length];
  const segment =
    profile.segments.find((item) => missionProgress >= item.start && missionProgress < item.end) ||
    profile.segments[profile.segments.length - 1];
  const pass = (missionProgress - segment.start) / (segment.end - segment.start);
  const fadeIn = THREE.MathUtils.smoothstep(missionProgress, 0, 0.018);
  const fadeOut = THREE.MathUtils.smoothstep(1 - missionProgress, 0, 0.018);
  return {
    cycleProgress,
    missionIndex,
    missionStartFrame,
    missionProgress,
    mode: segment.mode,
    pass,
    profile,
    visibility: fadeIn * fadeOut,
  };
}

function rocketRouteForMission(missionIndex, earthRotation) {
  return {
    landing: rocketVisibleSite(rocketLandingSites, missionIndex * 5 + 2, earthRotation),
    launch: rocketVisibleSite(rocketLaunchSites, missionIndex * 3, earthRotation),
  };
}

function rocketVisibleSite(sites, seed, earthRotation) {
  const rankedSites = sites
    .map((site) => ({
      facing: rocketSiteFacing(site, earthRotation),
      site,
    }))
    .sort((a, b) => b.facing - a.facing);
  const frontSites = rankedSites.filter((item) => item.facing > 0.02);
  const candidates = frontSites.length > 0 ? frontSites : rankedSites.slice(0, Math.ceil(rankedSites.length / 2));

  return candidates[seed % candidates.length].site;
}

function rocketSiteFacing(site, earthRotation) {
  const { normal } = rocketSiteBasis(site, earthRotation);
  normal.applyAxisAngle(zAxis, globeAxisTilt);
  normal.applyAxisAngle(xAxis, worldPitchTilt);
  return normal.z;
}

function rocketSiteBasis(site, earthRotation) {
  const latitude = THREE.MathUtils.degToRad(site.latitude);
  const longitude = THREE.MathUtils.degToRad(site.longitude);
  const azimuth = THREE.MathUtils.degToRad(site.azimuth);
  const cosLatitude = Math.cos(latitude);
  const sinLatitude = Math.sin(latitude);
  const cosLongitude = Math.cos(longitude);
  const sinLongitude = Math.sin(longitude);
  const normal = new THREE.Vector3(cosLatitude * cosLongitude, sinLatitude, -cosLatitude * sinLongitude);
  const east = new THREE.Vector3(-sinLongitude, 0, -cosLongitude).normalize();
  const north = new THREE.Vector3(-sinLatitude * cosLongitude, cosLatitude, sinLatitude * sinLongitude).normalize();
  const tangent = north.multiplyScalar(Math.cos(azimuth)).add(east.multiplyScalar(Math.sin(azimuth))).normalize();

  normal.applyAxisAngle(yAxis, earthRotation);
  tangent.applyAxisAngle(yAxis, earthRotation);

  return { normal, tangent };
}

function earthSurfaceNormal(latitudeDegrees, longitudeDegrees) {
  const latitude = THREE.MathUtils.degToRad(latitudeDegrees);
  const longitude = THREE.MathUtils.degToRad(longitudeDegrees);
  const cosLatitude = Math.cos(latitude);

  return new THREE.Vector3(cosLatitude * Math.cos(longitude), Math.sin(latitude), -cosLatitude * Math.sin(longitude));
}

function rocketMoonPosition(moonNode, moonArgument) {
  return new THREE.Vector3(moonOrbit.distance, 0, 0)
    .applyAxisAngle(yAxis, moonArgument)
    .applyAxisAngle(zAxis, moonOrbit.inclination)
    .applyAxisAngle(yAxis, moonNode);
}

function pitchToRocketFieldPosition(position) {
  return position.clone().applyAxisAngle(zAxis, -globeAxisTilt);
}

function rocketTransferPosition(pass, start, destination) {
  const easedTravel = easeInOut(THREE.MathUtils.clamp(pass, 0, 1));
  const distance = start.distanceTo(destination);
  let startRadial = start.clone();
  let destinationRadial = destination.clone();

  if (startRadial.lengthSq() < 0.000001) {
    startRadial = yAxis.clone();
  }

  if (destinationRadial.lengthSq() < 0.000001) {
    destinationRadial = yAxis.clone();
  }

  startRadial.normalize();
  destinationRadial.normalize();

  const controlOne = start.clone().add(startRadial.multiplyScalar(distance * rocketMission.transferLift));
  const controlTwo = destination.clone().add(destinationRadial.multiplyScalar(distance * rocketMission.transferLift * 0.82));
  const oneMinusT = 1 - easedTravel;

  return start
    .clone()
    .multiplyScalar(oneMinusT * oneMinusT * oneMinusT)
    .add(controlOne.multiplyScalar(3 * oneMinusT * oneMinusT * easedTravel))
    .add(controlTwo.multiplyScalar(3 * oneMinusT * easedTravel * easedTravel))
    .add(destination.clone().multiplyScalar(easedTravel * easedTravel * easedTravel));
}

function rocketOrbitAround(center, radial, normal, radius, pass, turns) {
  let orbitRadial = radial.clone();
  let orbitNormal = normal.clone();

  if (orbitRadial.lengthSq() < 0.000001) {
    orbitRadial = new THREE.Vector3(1, 0, 0);
  }

  if (orbitNormal.lengthSq() < 0.000001) {
    orbitNormal = yAxis.clone();
  }

  orbitRadial.normalize();
  orbitNormal.normalize();

  let tangent = orbitNormal.clone().cross(orbitRadial);
  if (tangent.lengthSq() < 0.000001) {
    tangent = zAxis.clone().cross(orbitRadial);
  }

  tangent.normalize();
  const angle = pass * Math.PI * 2 * turns;

  return center
    .clone()
    .add(orbitRadial.multiplyScalar(Math.cos(angle) * radius))
    .add(tangent.multiplyScalar(Math.sin(angle) * radius));
}

function rocketEarthOrbitPosition(pass, route, earthRotation) {
  const earthDeparture = rocketEarthArcPosition(1, "launch", route, earthRotation);
  return rocketOrbitAround(
    new THREE.Vector3(0, 0, 0),
    earthDeparture,
    yAxis,
    rocketMission.orbitRadius,
    pass,
    rocketMission.parkingOrbitTurns
  );
}

function issScenePosition(pass) {
  const angle = pass * Math.PI * 2;
  return new THREE.Vector3(Math.cos(angle) * issOrbit.radius, Math.sin(angle) * issOrbit.radius, 0).applyAxisAngle(
    xAxis,
    issOrbit.inclination
  );
}

function rocketEarthArcPosition(pass, mode, route, earthRotation) {
  const travel = mode === "launch" ? pass : 1 - pass;
  const easedTravel = easeInOut(THREE.MathUtils.clamp(travel, 0, 1));
  const site = mode === "launch" ? route.launch : route.landing;
  const { normal, tangent } = rocketSiteBasis(site, earthRotation);
  const ascentBlend =
    mode === "launch"
      ? Math.pow(THREE.MathUtils.clamp(easedTravel, 0, 1), 1.35)
      : THREE.MathUtils.smoothstep(easedTravel, 0.05, 0.62);
  const direction = normal
    .multiplyScalar(Math.cos(ascentBlend * rocketMission.sweep))
    .add(tangent.multiplyScalar(Math.sin(ascentBlend * rocketMission.sweep)))
    .normalize();
  const altitudeBlend =
    mode === "launch" ? Math.pow(THREE.MathUtils.clamp(easedTravel, 0, 1), 1.85) : ascentBlend;
  const radius = rocketMission.surfaceRadius + (rocketMission.orbitRadius - rocketMission.surfaceRadius) * altitudeBlend;

  return direction.multiplyScalar(radius);
}

function rocketLaunchDirection(pass, route, earthRotation, velocity) {
  const { normal, tangent } = rocketSiteBasis(route.launch, earthRotation);
  const launchUpright = normal.clone().add(tangent.clone().multiplyScalar(0.08)).normalize();
  const flightDirection = velocity.clone();

  if (flightDirection.lengthSq() < 0.000001) {
    flightDirection.copy(tangent);
  }

  const pitchOver = THREE.MathUtils.smoothstep(THREE.MathUtils.clamp(pass, 0, 1), 0.18, 0.64);

  return launchUpright.lerp(flightDirection.normalize(), pitchOver).normalize();
}

function rocketScenePosition(pass, mode, route, earthRotation, targets) {
  const earthDeparture = rocketEarthArcPosition(1, "launch", route, earthRotation);
  const earthOrbitExit = rocketEarthOrbitPosition(1, route, earthRotation);
  const moonTransferTarget = targets.moonTransfer || targets.moon;
  const marsTransferTarget = targets.marsTransfer || targets.mars;
  const moonRadial = targets.moon.clone().lengthSq() > 0.000001 ? targets.moon.clone().normalize() : yAxis.clone();
  const moonTransferRadial =
    moonTransferTarget.clone().lengthSq() > 0.000001 ? moonTransferTarget.clone().normalize() : yAxis.clone();
  const marsRadial = targets.mars.clone().lengthSq() > 0.000001 ? targets.mars.clone().normalize() : yAxis.clone();
  const marsTransferRadial =
    marsTransferTarget.clone().lengthSq() > 0.000001 ? marsTransferTarget.clone().normalize() : yAxis.clone();
  const moonOrbitStart = rocketOrbitAround(
    moonTransferTarget,
    moonTransferRadial.clone().multiplyScalar(-1),
    yAxis,
    rocketMission.lunarOrbitRadius,
    0,
    1
  );
  const marsOrbitStart = rocketOrbitAround(
    marsTransferTarget,
    marsTransferRadial.clone().multiplyScalar(-1),
    yAxis,
    rocketMission.marsOrbitRadius,
    0,
    1
  );

  if (mode === "launch") {
    return rocketEarthArcPosition(pass, mode, route, earthRotation);
  }

  if (mode === "earthOrbit") {
    return rocketEarthOrbitPosition(pass, route, earthRotation);
  }

  if (mode === "moonTransfer") {
    return rocketTransferPosition(pass, earthOrbitExit, moonOrbitStart);
  }

  if (mode === "moonOrbit") {
    return rocketOrbitAround(
      targets.moon,
      moonRadial.clone().multiplyScalar(-1),
      yAxis,
      rocketMission.lunarOrbitRadius,
      pass,
      1.35
    );
  }

  if (mode === "marsTransfer") {
    return rocketTransferPosition(pass, earthOrbitExit, marsOrbitStart);
  }

  if (mode === "marsOrbit") {
    return rocketOrbitAround(
      targets.mars,
      marsRadial.clone().multiplyScalar(-1),
      yAxis,
      rocketMission.marsOrbitRadius,
      pass,
      1.45
    );
  }

  return earthDeparture;
}

function scaledTime(startTime, startFrame, nowFrame, scale) {
  return startTime + (nowFrame - startFrame) * scale;
}

function endpointUrl(root) {
  const now = new Date();
  const params = new URLSearchParams({
    hours: String(now.getHours()),
    utcOffset: String(-now.getTimezoneOffset() / 60),
  });
  return `${root.dataset.endpoint}?${params.toString()}`;
}

function cleanCountry(country) {
  const compact = country.replace(/\s+,/g, ",").replace(/\s+/g, " ").trim();
  if (!compact) {
    return "";
  }
  return compact.startsWith(",") ? compact : `, ${compact}`;
}

function mealFromItem(item) {
  const hrefbt = item.getAttribute("hrefbt") || "";
  const fromQuery = hrefbt.match(/meal=([A-Za-z]+)-z(\d+)/);
  if (fromQuery) {
    return {
      meal: fromQuery[1].toLowerCase(),
      zone: Number(fromQuery[2]),
    };
  }

  const href = item.getAttribute("href") || "";
  const fromPath = href.match(/\/(breakfast|lunch|dinner|snack)\/[^/]+-z(\d+)\.png/i);
  return {
    meal: fromPath ? fromPath[1].toLowerCase() : "dinner",
    zone: fromPath ? Number(fromPath[2]) : Number(item.getAttribute("zone") || 0),
  };
}

function parseItems(xmlText) {
  const xml = new DOMParser().parseFromString(xmlText, "application/xml");
  const parserError = xml.querySelector("parsererror");
  if (parserError) {
    throw new Error("Invalid Heinz carousel XML");
  }

  return Array.from(xml.querySelectorAll("items > item")).map((node, index) => {
    const { meal, zone } = mealFromItem(node);
    const city = node.getAttribute("cityName") || "";
    const country = cleanCountry(node.getAttribute("country") || "");

    return {
      city,
      country,
      href: node.getAttribute("href"),
      id: Number(node.getAttribute("id") || index),
      logo: logoPath(meal, zone),
      meal,
      text: panelCopy[meal]?.[zone] || `${mealLabels[meal] || "Heinz"} in ${city}${country}`,
      utcOffset: Number(node.getAttribute("utcOffset") || 0),
      zone,
    };
  });
}

function updatePanelCopy(root, item) {
  const logo = root.querySelector("[data-heinz-panel-logo]");
  root.querySelector("[data-heinz-panel-city]").textContent = `${item.city}${item.country}`;
  root.querySelector("[data-heinz-panel-text]").textContent = item.text;
  logo.src = item.logo;
  logo.alt = "";
}

function buildCityStrip(root, items, selectPane) {
  const strip = root.querySelector("[data-heinz-cities]");
  strip.innerHTML = "";

  const highlight = document.createElement("div");
  highlight.className = "heinz-world-city-highlight";
  highlight.setAttribute("aria-hidden", "true");
  strip.append(highlight);

  items.forEach((item, index) => {
    const button = document.createElement("button");
    button.type = "button";
    button.textContent = item.city;
    button.addEventListener("click", () => selectPane(index));
    strip.append(button);
  });
}

function setActiveCity(root, index, duration = 0) {
  const strip = root.querySelector("[data-heinz-cities]");
  const buttons = Array.from(root.querySelectorAll("[data-heinz-cities] button"));
  const activeButton = buttons[index];

  if (!strip || !activeButton) {
    return;
  }

  strip.style.setProperty("--heinz-city-highlight-duration", `${duration}ms`);
  strip.style.setProperty("--heinz-city-highlight-x", `${activeButton.offsetLeft}px`);
  strip.style.setProperty("--heinz-city-highlight-width", `${activeButton.offsetWidth}px`);

  buttons.forEach((button, buttonIndex) => {
    button.classList.toggle("active", buttonIndex === index);
  });
}

function loadTexture(loader, url, renderer) {
  return new Promise((resolve, reject) => {
    loader.load(
      url,
      (texture) => {
        texture.colorSpace = THREE.SRGBColorSpace;
        texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
        resolve(texture);
      },
      undefined,
      reject
    );
  });
}

function mirrorHorizontalSeam(context, canvas, gutter) {
  const seamWidth = Math.min(gutter, Math.floor(canvas.width / 2));
  const image = context.getImageData(0, 0, canvas.width, canvas.height);
  const pixels = image.data;
  const divisor = Math.max(1, seamWidth - 1);

  for (let y = 0; y < canvas.height; y += 1) {
    for (let x = 0; x < seamWidth; x += 1) {
      const blend = Math.pow(1 - x / divisor, 2);
      const left = (y * canvas.width + x) * 4;
      const right = (y * canvas.width + (canvas.width - 1 - x)) * 4;

      for (let channel = 0; channel < 4; channel += 1) {
        const average = (pixels[left + channel] + pixels[right + channel]) / 2;
        pixels[left + channel] = Math.round(pixels[left + channel] * (1 - blend) + average * blend);
        pixels[right + channel] = Math.round(pixels[right + channel] * (1 - blend) + average * blend);
      }
    }
  }

  context.putImageData(image, 0, 0);
}

function seamlessEquirectTexture(renderer, image, gutter = 12) {
  const canvas = document.createElement("canvas");
  canvas.width = image.naturalWidth || image.width;
  canvas.height = image.naturalHeight || image.height;
  const context = canvas.getContext("2d");
  context.drawImage(image, 0, 0, canvas.width, canvas.height);
  mirrorHorizontalSeam(context, canvas, gutter);

  const texture = new THREE.CanvasTexture(canvas);
  texture.colorSpace = THREE.SRGBColorSpace;
  texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
  texture.wrapS = THREE.RepeatWrapping;
  texture.needsUpdate = true;
  return texture;
}

function earthSurfaceTexture(renderer, landImage) {
  const canvas = document.createElement("canvas");
  canvas.width = landImage.naturalWidth || landImage.width;
  canvas.height = landImage.naturalHeight || landImage.height;
  const context = canvas.getContext("2d");
  const maskCanvas = document.createElement("canvas");
  maskCanvas.width = canvas.width;
  maskCanvas.height = canvas.height;
  const maskContext = maskCanvas.getContext("2d");

  maskContext.drawImage(landImage, 0, 0, maskCanvas.width, maskCanvas.height);

  const mask = maskContext.getImageData(0, 0, maskCanvas.width, maskCanvas.height).data;
  const image = context.createImageData(canvas.width, canvas.height);
  const pixels = image.data;

  for (let y = 0; y < canvas.height; y += 1) {
    const v = y / (canvas.height - 1);
    const latitude = Math.abs(v * 2 - 1);
    const polarIce = THREE.MathUtils.smoothstep(latitude, 0.78, 0.96);

    for (let x = 0; x < canvas.width; x += 1) {
      const u = x / canvas.width;
      const offset = (y * canvas.width + x) * 4;
      const landAlpha = mask[offset + 3] / 255;
      const landMask = THREE.MathUtils.smoothstep(landAlpha, 0.04, 0.55);
      const broad = octaveNoise(u * 5.7 + 3.1, v * 3.4 + 7.2);
      const fine = octaveNoise(u * 19.3 + 11.7, v * 10.8 + 2.4);
      const oceanCurrent = Math.sin(u * Math.PI * 18 + v * 11.5) * 0.035;
      const oceanDepth = THREE.MathUtils.clamp(broad * 0.68 + fine * 0.22 + oceanCurrent, 0, 1);
      const landTone = THREE.MathUtils.clamp(broad * 0.52 + fine * 0.38 + latitude * 0.18, 0, 1);

      const ocean = [
        Math.round(8 + oceanDepth * 28 + polarIce * 28),
        Math.round(58 + oceanDepth * 48 + polarIce * 38),
        Math.round(108 + oceanDepth * 62 + polarIce * 34),
      ];
      const land = [
        Math.round(43 + landTone * 72 + polarIce * 72),
        Math.round(76 + landTone * 70 + polarIce * 78),
        Math.round(36 + landTone * 35 + polarIce * 74),
      ];
      const coast = THREE.MathUtils.smoothstep(landAlpha, 0.01, 0.18);
      const shoreline = coast * (1 - landMask) * 42;

      pixels[offset] = Math.round(THREE.MathUtils.lerp(ocean[0] + shoreline, land[0], landMask));
      pixels[offset + 1] = Math.round(THREE.MathUtils.lerp(ocean[1] + shoreline, land[1], landMask));
      pixels[offset + 2] = Math.round(THREE.MathUtils.lerp(ocean[2] + shoreline * 0.9, land[2], landMask));
      pixels[offset + 3] = Math.round((0.42 + landMask * 0.28 + polarIce * 0.1) * 255);
    }
  }

  context.putImageData(image, 0, 0);
  context.globalCompositeOperation = "source-over";
  context.fillStyle = "rgba(255, 255, 255, 0.035)";
  for (let index = 0; index < 34; index += 1) {
    const y = canvas.height * (0.12 + seededUnit(index + 900) * 0.76);
    const height = canvas.height * (0.002 + seededUnit(index + 930) * 0.005);
    context.fillRect(0, y, canvas.width, height);
  }
  mirrorHorizontalSeam(context, canvas, 96);

  const texture = new THREE.CanvasTexture(canvas);
  texture.colorSpace = THREE.SRGBColorSpace;
  texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
  texture.wrapS = THREE.RepeatWrapping;
  texture.needsUpdate = true;
  return texture;
}

function compositedPaneTexture(renderer, paneImage, overlayImage) {
  const canvas = document.createElement("canvas");
  canvas.width = paneImage.naturalWidth || paneImage.width;
  canvas.height = paneImage.naturalHeight || paneImage.height;

  const context = canvas.getContext("2d");
  context.drawImage(paneImage, 0, 0, canvas.width, canvas.height);
  context.drawImage(overlayImage, 0, 0, canvas.width, canvas.height);

  const cornerRadius = canvas.width * 0.018;
  const overlayTop = canvas.height * 0.628;
  context.save();
  context.beginPath();
  context.moveTo(0, overlayTop);
  context.lineTo(canvas.width, overlayTop);
  context.lineTo(canvas.width, canvas.height - cornerRadius);
  context.quadraticCurveTo(canvas.width, canvas.height, canvas.width - cornerRadius, canvas.height);
  context.lineTo(cornerRadius, canvas.height);
  context.quadraticCurveTo(0, canvas.height, 0, canvas.height - cornerRadius);
  context.closePath();
  context.clip();
  context.fillStyle = "rgba(255, 255, 255, 0.760784)";
  context.fillRect(0, canvas.height - 1, canvas.width, 1);
  context.restore();

  const texture = new THREE.CanvasTexture(canvas);
  texture.colorSpace = THREE.SRGBColorSpace;
  texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
  texture.needsUpdate = true;
  return texture;
}

function planetTexture(renderer, planet) {
  const canvas = document.createElement("canvas");
  canvas.width = 192;
  canvas.height = 96;
  const context = canvas.getContext("2d");
  context.fillStyle = planet.base;
  context.fillRect(0, 0, canvas.width, canvas.height);

  if (planet.stripes) {
    planet.stripes.forEach((color, index) => {
      const stripeY = ((index + 0.6) / planet.stripes.length) * canvas.height;
      context.fillStyle = color;
      context.globalAlpha = 0.34;
      context.beginPath();
      context.ellipse(canvas.width / 2, stripeY, canvas.width * 0.6, canvas.height * 0.09, 0, 0, Math.PI * 2);
      context.fill();
    });
    context.globalAlpha = 1;
  }

  const glow = context.createRadialGradient(
    canvas.width * 0.3,
    canvas.height * 0.28,
    canvas.height * 0.08,
    canvas.width * 0.5,
    canvas.height * 0.5,
    canvas.height * 0.65
  );
  glow.addColorStop(0, "rgba(255, 255, 255, 0.32)");
  glow.addColorStop(0.45, "rgba(255, 255, 255, 0.04)");
  glow.addColorStop(1, "rgba(0, 0, 0, 0.38)");
  context.fillStyle = glow;
  context.fillRect(0, 0, canvas.width, canvas.height);

  const texture = new THREE.CanvasTexture(canvas);
  texture.colorSpace = THREE.SRGBColorSpace;
  texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
  texture.needsUpdate = true;
  return texture;
}

function eclipticPlateTexture(renderer) {
  const canvas = document.createElement("canvas");
  canvas.width = 1024;
  canvas.height = 512;
  const context = canvas.getContext("2d");
  context.clearRect(0, 0, canvas.width, canvas.height);

  const centerX = canvas.width / 2;
  const centerY = canvas.height / 2;
  const radiusX = canvas.width * 0.48;
  const radiusY = canvas.height * 0.42;
  const plate = context.createRadialGradient(centerX, centerY, canvas.height * 0.04, centerX, centerY, radiusX);
  plate.addColorStop(0, "rgba(213, 232, 255, 0.12)");
  plate.addColorStop(0.48, "rgba(152, 197, 255, 0.06)");
  plate.addColorStop(0.82, "rgba(83, 141, 214, 0.025)");
  plate.addColorStop(1, "rgba(0, 0, 0, 0)");

  context.save();
  context.beginPath();
  context.ellipse(centerX, centerY, radiusX, radiusY, 0, 0, Math.PI * 2);
  context.clip();
  context.fillStyle = plate;
  context.fillRect(0, 0, canvas.width, canvas.height);

  const midline = context.createLinearGradient(0, centerY - 12, 0, centerY + 12);
  midline.addColorStop(0, "rgba(255, 255, 255, 0)");
  midline.addColorStop(0.5, "rgba(226, 240, 255, 0.28)");
  midline.addColorStop(1, "rgba(255, 255, 255, 0)");
  context.fillStyle = midline;
  context.fillRect(centerX - radiusX * 0.92, centerY - 12, radiusX * 1.84, 24);

  context.strokeStyle = "rgba(214, 232, 255, 0.08)";
  context.lineWidth = 1;
  for (let index = -4; index <= 4; index += 1) {
    const y = centerY + index * radiusY * 0.18;
    context.beginPath();
    context.ellipse(centerX, y, radiusX * (1 - Math.abs(index) * 0.055), radiusY * 0.08, 0, 0, Math.PI * 2);
    context.stroke();
  }

  context.fillStyle = "rgba(238, 247, 255, 0.38)";
  for (let index = 0; index < 48; index += 1) {
    const angle = (index / 48) * Math.PI * 2;
    const x = centerX + Math.cos(angle) * radiusX * 0.88;
    const y = centerY + Math.sin(angle) * radiusY * 0.78;
    context.beginPath();
    context.arc(x, y, index % 6 === 0 ? 1.9 : 1.1, 0, Math.PI * 2);
    context.fill();
  }
  context.restore();

  const texture = new THREE.CanvasTexture(canvas);
  texture.colorSpace = THREE.SRGBColorSpace;
  texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
  texture.needsUpdate = true;
  return texture;
}

function cometTexture(renderer) {
  const canvas = document.createElement("canvas");
  canvas.width = 768;
  canvas.height = 160;
  const context = canvas.getContext("2d");
  context.clearRect(0, 0, canvas.width, canvas.height);

  const centerY = canvas.height / 2;
  const tail = context.createLinearGradient(0, centerY, canvas.width * 0.88, centerY);
  tail.addColorStop(0, "rgba(180, 216, 255, 0)");
  tail.addColorStop(0.35, "rgba(176, 219, 255, 0.12)");
  tail.addColorStop(0.78, "rgba(218, 242, 255, 0.44)");
  tail.addColorStop(1, "rgba(255, 255, 255, 0.86)");

  context.save();
  context.translate(canvas.width * 0.84, centerY);
  context.rotate(THREE.MathUtils.degToRad(-2.5));
  context.beginPath();
  context.moveTo(-canvas.width * 0.8, -canvas.height * 0.08);
  context.quadraticCurveTo(-canvas.width * 0.38, -canvas.height * 0.34, 0, -canvas.height * 0.1);
  context.quadraticCurveTo(canvas.width * 0.08, 0, 0, canvas.height * 0.1);
  context.quadraticCurveTo(-canvas.width * 0.38, canvas.height * 0.34, -canvas.width * 0.8, canvas.height * 0.08);
  context.closePath();
  context.fillStyle = tail;
  context.fill();
  context.restore();

  const coma = context.createRadialGradient(canvas.width * 0.84, centerY, 0, canvas.width * 0.84, centerY, canvas.height * 0.33);
  coma.addColorStop(0, "rgba(255, 255, 255, 1)");
  coma.addColorStop(0.18, "rgba(235, 248, 255, 0.78)");
  coma.addColorStop(0.55, "rgba(157, 212, 255, 0.22)");
  coma.addColorStop(1, "rgba(105, 172, 255, 0)");
  context.fillStyle = coma;
  context.beginPath();
  context.arc(canvas.width * 0.84, centerY, canvas.height * 0.36, 0, Math.PI * 2);
  context.fill();

  const texture = new THREE.CanvasTexture(canvas);
  texture.colorSpace = THREE.SRGBColorSpace;
  texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
  texture.needsUpdate = true;
  return texture;
}

function stormCellTexture(renderer) {
  const canvas = document.createElement("canvas");
  canvas.width = 256;
  canvas.height = 256;
  const context = canvas.getContext("2d");
  context.clearRect(0, 0, canvas.width, canvas.height);

  const center = canvas.width / 2;
  const haze = context.createRadialGradient(center, center, 4, center, center, canvas.width * 0.46);
  haze.addColorStop(0, "rgba(255, 255, 255, 0.5)");
  haze.addColorStop(0.32, "rgba(238, 248, 255, 0.34)");
  haze.addColorStop(0.7, "rgba(218, 234, 246, 0.13)");
  haze.addColorStop(1, "rgba(255, 255, 255, 0)");
  context.fillStyle = haze;
  context.fillRect(0, 0, canvas.width, canvas.height);

  context.save();
  context.translate(center, center);
  context.rotate(THREE.MathUtils.degToRad(-18));
  context.lineCap = "round";
  context.lineJoin = "round";

  for (let band = 0; band < 18; band += 1) {
    const start = -0.75 + band * 0.09;
    const radius = canvas.width * (0.16 + band * 0.011);
    const alpha = 0.12 + (1 - band / 18) * 0.2;
    context.strokeStyle = `rgba(246, 251, 255, ${alpha.toFixed(3)})`;
    context.lineWidth = 5.4 - band * 0.17;
    context.beginPath();
    context.arc(0, 0, radius, start, start + Math.PI * (0.55 + band * 0.018));
    context.stroke();
  }

  for (let puff = 0; puff < 34; puff += 1) {
    const angle = seededUnit(300 + puff) * Math.PI * 2;
    const distance = canvas.width * (0.06 + seededUnit(420 + puff) * 0.28);
    const x = Math.cos(angle) * distance;
    const y = Math.sin(angle) * distance * 0.72;
    const radiusX = canvas.width * (0.025 + seededUnit(540 + puff) * 0.055);
    const radiusY = canvas.width * (0.012 + seededUnit(660 + puff) * 0.032);
    context.fillStyle = `rgba(255, 255, 255, ${(0.06 + seededUnit(780 + puff) * 0.16).toFixed(3)})`;
    context.beginPath();
    context.ellipse(x, y, radiusX, radiusY, angle * 0.4, 0, Math.PI * 2);
    context.fill();
  }

  context.restore();

  const texture = new THREE.CanvasTexture(canvas);
  texture.colorSpace = THREE.SRGBColorSpace;
  texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
  texture.needsUpdate = true;
  return texture;
}

function lightningTexture(renderer) {
  const canvas = document.createElement("canvas");
  canvas.width = 256;
  canvas.height = 256;
  const context = canvas.getContext("2d");
  context.clearRect(0, 0, canvas.width, canvas.height);
  context.lineCap = "round";
  context.lineJoin = "round";

  function drawBolt(seed, lineWidth, alpha) {
    const points = [];
    let x = canvas.width * (0.44 + seededUnit(seed) * 0.12);
    let y = canvas.height * 0.18;

    points.push([x, y]);
    for (let index = 1; index < 8; index += 1) {
      x += (seededUnit(seed + index * 3.7) - 0.5) * canvas.width * 0.18;
      y += canvas.height * (0.07 + seededUnit(seed + index * 5.1) * 0.08);
      points.push([x, y]);
    }

    context.strokeStyle = `rgba(234, 248, 255, ${alpha.toFixed(3)})`;
    context.lineWidth = lineWidth;
    context.beginPath();
    points.forEach(([pointX, pointY], index) => {
      if (index === 0) {
        context.moveTo(pointX, pointY);
      } else {
        context.lineTo(pointX, pointY);
      }
    });
    context.stroke();

    [2, 4, 5].forEach((pointIndex, branchIndex) => {
      const [branchX, branchY] = points[pointIndex];
      const branchLength = canvas.width * (0.11 + seededUnit(seed + branchIndex * 8.9) * 0.12);
      const branchAngle = (seededUnit(seed + branchIndex * 11.4) - 0.5) * 1.25;
      context.beginPath();
      context.moveTo(branchX, branchY);
      context.lineTo(branchX + Math.cos(branchAngle) * branchLength, branchY + Math.sin(branchAngle) * branchLength);
      context.stroke();
    });
  }

  context.shadowBlur = 14;
  context.shadowColor = "rgba(154, 218, 255, 0.9)";
  drawBolt(17, 5.2, 0.42);
  context.shadowBlur = 4;
  drawBolt(17, 1.8, 0.95);

  const glow = context.createRadialGradient(
    canvas.width * 0.52,
    canvas.height * 0.52,
    0,
    canvas.width * 0.52,
    canvas.height * 0.52,
    canvas.width * 0.38
  );
  glow.addColorStop(0, "rgba(168, 222, 255, 0.2)");
  glow.addColorStop(0.4, "rgba(138, 205, 255, 0.08)");
  glow.addColorStop(1, "rgba(255, 255, 255, 0)");
  context.fillStyle = glow;
  context.fillRect(0, 0, canvas.width, canvas.height);

  const texture = new THREE.CanvasTexture(canvas);
  texture.colorSpace = THREE.SRGBColorSpace;
  texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
  texture.needsUpdate = true;
  return texture;
}

function lerp(start, end, amount) {
  return start + (end - start) * amount;
}

function valueNoise(x, y) {
  const x0 = Math.floor(x);
  const y0 = Math.floor(y);
  const x1 = x0 + 1;
  const y1 = y0 + 1;
  const sx = THREE.MathUtils.smootherstep(fract(x), 0, 1);
  const sy = THREE.MathUtils.smootherstep(fract(y), 0, 1);
  const n00 = fract(Math.sin(x0 * 127.1 + y0 * 311.7) * 43758.5453123);
  const n10 = fract(Math.sin(x1 * 127.1 + y0 * 311.7) * 43758.5453123);
  const n01 = fract(Math.sin(x0 * 127.1 + y1 * 311.7) * 43758.5453123);
  const n11 = fract(Math.sin(x1 * 127.1 + y1 * 311.7) * 43758.5453123);
  return lerp(lerp(n00, n10, sx), lerp(n01, n11, sx), sy);
}

function octaveNoise(x, y) {
  let amplitude = 0.52;
  let frequency = 1;
  let total = 0;
  let value = 0;

  for (let octave = 0; octave < 5; octave += 1) {
    value += valueNoise(x * frequency, y * frequency) * amplitude;
    total += amplitude;
    amplitude *= 0.52;
    frequency *= 2.17;
  }

  return value / total;
}

function cloudTexture(renderer) {
  const canvas = document.createElement("canvas");
  canvas.width = 1024;
  canvas.height = 512;
  const context = canvas.getContext("2d");
  const image = context.createImageData(canvas.width, canvas.height);
  const pixels = image.data;

  for (let y = 0; y < canvas.height; y += 1) {
    const v = y / (canvas.height - 1);
    const latitude = Math.abs(v * 2 - 1);
    const tropicalBand = Math.exp(-Math.pow((latitude - 0.18) / 0.16, 2));
    const midLatitudeBand = Math.exp(-Math.pow((latitude - 0.56) / 0.22, 2));
    const polarFalloff = 1 - THREE.MathUtils.smoothstep(latitude, 0.82, 1);
    const bandStrength = Math.max(tropicalBand * 0.92, midLatitudeBand * 0.76) * polarFalloff;

    for (let x = 0; x < canvas.width; x += 1) {
      const u = x / canvas.width;
      const stream =
        Math.sin(u * Math.PI * 12 + v * 19) * 0.08 +
        Math.sin(u * Math.PI * 23 - v * 31) * 0.045;
      const curl =
        octaveNoise(u * 7.8 + Math.sin(v * Math.PI * 7) * 0.25, v * 5.2 + Math.cos(u * Math.PI * 6) * 0.12);
      const fine =
        octaveNoise(u * 23.5 + Math.sin(v * Math.PI * 13) * 0.1, v * 15.4 + Math.cos(u * Math.PI * 9) * 0.08);
      const cover = curl * 0.72 + fine * 0.24 + stream + bandStrength * 0.34 - latitude * 0.1;
      const alpha =
        THREE.MathUtils.smoothstep(cover, 0.52, 0.78) *
        (0.28 + bandStrength * 0.72) *
        polarFalloff;
      const offset = (y * canvas.width + x) * 4;
      pixels[offset] = 245;
      pixels[offset + 1] = 249;
      pixels[offset + 2] = 255;
      pixels[offset + 3] = Math.round(Math.min(0.92, alpha) * 255);
    }
  }

  context.putImageData(image, 0, 0);
  context.globalCompositeOperation = "source-over";
  context.filter = "blur(1.4px)";
  for (let index = 0; index < 26; index += 1) {
    const x = canvas.width * fract(Math.sin(index * 26.51) * 81237.19);
    const y = canvas.height * (0.22 + fract(Math.sin(index * 71.29) * 23198.37) * 0.56);
    const radiusX = canvas.width * (0.018 + fract(Math.sin(index * 41.77) * 53791.1) * 0.035);
    const radiusY = canvas.height * (0.006 + fract(Math.sin(index * 83.13) * 37112.83) * 0.018);
    context.save();
    context.translate(x, y);
    context.rotate((fract(Math.sin(index * 12.9) * 16342.9) - 0.5) * 1.2);
    context.fillStyle = "rgba(255, 255, 255, 0.26)";
    context.beginPath();
    context.ellipse(0, 0, radiusX, radiusY, 0, 0, Math.PI * 2);
    context.fill();
    context.restore();
  }
  context.filter = "none";
  mirrorHorizontalSeam(context, canvas, 96);

  const texture = new THREE.CanvasTexture(canvas);
  texture.colorSpace = THREE.SRGBColorSpace;
  texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
  texture.wrapS = THREE.RepeatWrapping;
  texture.needsUpdate = true;
  return texture;
}

function galacticCoreTexture(renderer) {
  const canvas = document.createElement("canvas");
  canvas.width = 1536;
  canvas.height = 1024;
  const context = canvas.getContext("2d");
  context.clearRect(0, 0, canvas.width, canvas.height);

  for (let index = 0; index < 520; index += 1) {
    const x = canvas.width * fract(Math.sin(index * 34.879) * 98123.271);
    const y = canvas.height * fract(Math.sin(index * 19.173) * 43127.521);
    const radius = 0.35 + fract(Math.sin(index * 91.411) * 17321.937) * 1.2;
    const alpha = 0.1 + fract(Math.sin(index * 53.719) * 69213.617) * 0.26;
    context.fillStyle = `rgba(231, 239, 255, ${alpha.toFixed(3)})`;
    context.beginPath();
    context.arc(x, y, radius, 0, Math.PI * 2);
    context.fill();
  }

  const core = context.createRadialGradient(
    canvas.width * 0.52,
    canvas.height * 0.47,
    4,
    canvas.width * 0.52,
    canvas.height * 0.47,
    canvas.width * 0.38
  );
  core.addColorStop(0, "rgba(255, 236, 184, 0.2)");
  core.addColorStop(0.18, "rgba(213, 177, 111, 0.11)");
  core.addColorStop(0.55, "rgba(128, 132, 160, 0.055)");
  core.addColorStop(1, "rgba(0, 0, 0, 0)");
  context.fillStyle = core;
  context.fillRect(0, 0, canvas.width, canvas.height);

  for (let index = 0; index < 260; index += 1) {
    const band = index / 259;
    const x = canvas.width * fract(Math.sin(index * 12.9898) * 43758.5453);
    const y =
      canvas.height * 0.47 +
      Math.sin(index * 0.44) * canvas.height * 0.09 +
      (band - 0.5) * canvas.height * 0.18;
    const radius = 0.55 + fract(Math.sin(index * 78.233) * 23454.91) * 1.35;
    context.fillStyle = index % 7 === 0 ? "rgba(255, 231, 181, 0.55)" : "rgba(228, 236, 255, 0.34)";
    context.beginPath();
    context.arc((x + canvas.width) % canvas.width, y, radius, 0, Math.PI * 2);
    context.fill();
  }

  const texture = new THREE.CanvasTexture(canvas);
  texture.colorSpace = THREE.SRGBColorSpace;
  texture.anisotropy = renderer.capabilities.getMaxAnisotropy();
  texture.needsUpdate = true;
  return texture;
}

async function initWorld(root, items) {
  const canvas = root.querySelector("[data-heinz-canvas]");
  const nightRoot = root.closest(".heinz-original-site") || root;
  const renderer = new THREE.WebGLRenderer({
    alpha: true,
    antialias: true,
    canvas,
    powerPreference: "high-performance",
  });
  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(35, 837 / 440, 0.1, 100);
  const loader = new THREE.TextureLoader();
  const world = new THREE.Group();
  const pitch = new THREE.Group();
  const globeAxis = new THREE.Group();
  const globeSpin = new THREE.Group();
  const moonOrbitNode = new THREE.Group();
  const moonOrbitPlane = new THREE.Group();
  const moonOrbitSpin = new THREE.Group();
  const planetField = new THREE.Group();
  const rocketField = new THREE.Group();
  const galacticField = new THREE.Group();
  const cometField = new THREE.Group();
  const asteroidField = new THREE.Group();
  const rotatePlanes = new THREE.Group();
  const raycaster = new THREE.Raycaster();
  const pointer = new THREE.Vector2();
  const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  const celestialStartFrame = performance.now();
  const celestialStartTime = Date.now();
  const state = {
    animating: false,
    duration: 1,
    from: 0,
    lastDirection: -1,
    pending: 0,
    run: 0,
    selected: 0,
    started: 0,
    target: 0,
    idleResumeAt: 0,
  };
  const panels = [];
  const nightMaterials = [];
  const cometSprites = [];
  const rocketMaterials = [];
  const stormSystems = [];
  const planetMeshes = [];
  const cityStrip = root.querySelector("[data-heinz-cities]");
  const disposableGeometries = [];
  const disposableMaterials = [];
  const disposableTextures = [];
  let animationFrame = 0;
  let activeRocketMissionIndex = -1;
  let activeRocketRoute;
  let activeRocketTransferTargets;
  let panelOpenFrame = 0;
  let handleClick = () => {};
  let handlePointerLeave = () => {};
  let handlePointerMove = () => {};
  let resizeObserver;
  let disposed = false;

  function cleanup() {
    if (disposed) {
      return;
    }

    disposed = true;
    if (animationFrame) {
      cancelAnimationFrame(animationFrame);
      animationFrame = 0;
    }
    if (panelOpenFrame) {
      cancelAnimationFrame(panelOpenFrame);
      panelOpenFrame = 0;
    }
    if (resizeObserver) {
      resizeObserver.disconnect();
      resizeObserver = undefined;
    }

    canvas.removeEventListener("pointermove", handlePointerMove);
    canvas.removeEventListener("pointerleave", handlePointerLeave);
    canvas.removeEventListener("click", handleClick);
    canvas.classList.remove("is-clickable");
    root.classList.remove("heinz-world-ready", "heinz-world-spinning", "heinz-world-panel-open");
    nightRoot.style.removeProperty("--heinz-world-night");
    if (cityStrip) {
      cityStrip.innerHTML = "";
    }

    disposableTextures.forEach((texture) => texture.dispose());
    disposableGeometries.forEach((geometry) => geometry.dispose());
    disposableMaterials.forEach((material) => material.dispose());
    renderer.dispose();
  }

  try {
    camera.fov = THREE.MathUtils.radToDeg(2 * Math.atan(4.4 / (2 * 5.81)));
    camera.position.set(0, 0, 9.7);
    camera.updateProjectionMatrix();
    scene.add(world);
    world.add(pitch);
    pitch.add(globeAxis);
    globeAxis.add(globeSpin);
    globeAxis.add(rocketField);
    globeAxis.rotation.z = globeAxisTilt;
    pitch.add(moonOrbitNode);
    moonOrbitNode.add(moonOrbitPlane);
    moonOrbitPlane.add(moonOrbitSpin);
    moonOrbitPlane.rotation.z = moonOrbit.inclination;
    pitch.add(galacticField);
    pitch.add(asteroidField);
    pitch.add(cometField);
    pitch.add(planetField);
    pitch.add(rotatePlanes);
    pitch.rotation.x = worldPitchTilt;
    world.position.y = -1.25;

    const [moonMap, countriesTexture, overlayTexture, ...paneTextures] = await Promise.all([
      loadTexture(loader, root.dataset.moonMap, renderer),
      loadTexture(loader, root.dataset.earthCountriesMap, renderer),
      loadTexture(loader, root.dataset.overlayMap, renderer),
      ...items.map((item) => loadTexture(loader, item.href, renderer)),
    ]);
    const paneOpenTextures = paneTextures.map((texture) =>
      compositedPaneTexture(renderer, texture.image, overlayTexture.image)
    );
    const countriesMap = seamlessEquirectTexture(renderer, countriesTexture.image, 18);
    const earthSurfaceMap = earthSurfaceTexture(renderer, countriesTexture.image);
    const cloudMap = cloudTexture(renderer);
    const cometMap = cometTexture(renderer);
    const eclipticPlateMap = eclipticPlateTexture(renderer);
    const galacticCoreMap = galacticCoreTexture(renderer);
    const stormMap = stormCellTexture(renderer);
    const lightningMap = lightningTexture(renderer);
    disposableTextures.push(
      moonMap,
      countriesTexture,
      countriesMap,
      earthSurfaceMap,
      overlayTexture,
      cloudMap,
      cometMap,
      eclipticPlateMap,
      galacticCoreMap,
      stormMap,
      lightningMap,
      ...paneTextures,
      ...paneOpenTextures
    );

    const galacticGeometry = new THREE.PlaneGeometry(30, 20, 1, 1);
    const galacticMaterial = new THREE.MeshBasicMaterial({
      depthWrite: false,
      map: galacticCoreMap,
      opacity: 0,
      side: THREE.DoubleSide,
      transparent: true,
    });
    const galacticCore = new THREE.Mesh(galacticGeometry, galacticMaterial);
    galacticCore.position.set(0.45, 1.3, -6.85);
    galacticCore.rotation.z = THREE.MathUtils.degToRad(-9);
    galacticCore.renderOrder = -4;
    galacticField.add(galacticCore);
    nightMaterials.push({ material: galacticMaterial, opacity: 0.62 });
    disposableGeometries.push(galacticGeometry);
    disposableMaterials.push(galacticMaterial);

    const eclipticGeometry = new THREE.PlaneGeometry(eclipticPlate.width, eclipticPlate.depth, 1, 1);
    const eclipticMaterial = new THREE.MeshBasicMaterial({
      depthWrite: false,
      map: eclipticPlateMap,
      opacity: 0,
      side: THREE.DoubleSide,
      transparent: true,
    });
    const ecliptic = new THREE.Mesh(eclipticGeometry, eclipticMaterial);
    ecliptic.position.set(0, planetScene.baseHeight, planetScene.baseDepth);
    ecliptic.rotation.x = Math.atan2(planetScene.eclipticDepth, planetScene.eclipticLift);
    ecliptic.renderOrder = -5;
    pitch.add(ecliptic);
    nightMaterials.push({ material: eclipticMaterial, opacity: eclipticPlate.opacity });
    disposableGeometries.push(eclipticGeometry);
    disposableMaterials.push(eclipticMaterial);

    const dustGeometry = eclipticParticleGeometry(asteroidBelt.dustCount, false);
    const dustMaterial = new THREE.PointsMaterial({
      depthWrite: false,
      opacity: 0,
      size: asteroidBelt.dustSize,
      sizeAttenuation: true,
      transparent: true,
      vertexColors: true,
    });
    const dust = new THREE.Points(dustGeometry, dustMaterial);
    dust.renderOrder = -4;
    asteroidField.add(dust);
    nightMaterials.push({ material: dustMaterial, opacity: asteroidBelt.dustOpacity });
    disposableGeometries.push(dustGeometry);
    disposableMaterials.push(dustMaterial);

    const asteroidGeometry = eclipticParticleGeometry(asteroidBelt.asteroidCount, true);
    const asteroidMaterial = new THREE.PointsMaterial({
      depthWrite: false,
      opacity: 0,
      size: asteroidBelt.asteroidSize,
      sizeAttenuation: true,
      transparent: true,
      vertexColors: true,
    });
    const asteroids = new THREE.Points(asteroidGeometry, asteroidMaterial);
    asteroids.renderOrder = -3;
    asteroidField.add(asteroids);
    nightMaterials.push({ material: asteroidMaterial, opacity: asteroidBelt.asteroidOpacity });
    disposableGeometries.push(asteroidGeometry);
    disposableMaterials.push(asteroidMaterial);

    visibleComets.forEach((comet) => {
      const material = new THREE.SpriteMaterial({
        depthWrite: false,
        map: cometMap,
        opacity: 0,
        transparent: true,
      });
      const sprite = new THREE.Sprite(material);
      sprite.center.set(0.84, 0.5);
      sprite.renderOrder = -1;
      sprite.userData.comet = comet;
      cometField.add(sprite);
      cometSprites.push(sprite);
      disposableMaterials.push(material);
    });

    const moonGeometry = new THREE.SphereGeometry(0.34, 36, 18);
    const moonMaterial = new THREE.MeshBasicMaterial({
      depthWrite: false,
      map: moonMap,
      opacity: 0.76,
      transparent: true,
    });
    const moon = new THREE.Mesh(moonGeometry, moonMaterial);
    moon.position.set(moonOrbit.distance, 0, 0);
    moon.rotation.set(THREE.MathUtils.degToRad(8), THREE.MathUtils.degToRad(90), 0);
    disposableGeometries.push(moonGeometry);
    disposableMaterials.push(moonMaterial);
    moonOrbitSpin.add(moon);

    const planetGeometry = new THREE.SphereGeometry(1, 24, 12);
    disposableGeometries.push(planetGeometry);
    visiblePlanets.forEach((planet) => {
      const texture = planetTexture(renderer, planet);
      const material = new THREE.MeshBasicMaterial({
        depthWrite: false,
        map: texture,
        opacity: 0,
        transparent: true,
      });
      const mesh = new THREE.Mesh(planetGeometry, material);
      mesh.name = planet.name;
      mesh.scale.setScalar(planet.radius);
      mesh.renderOrder = -2;
      mesh.userData.planetTarget = planet.target;
      mesh.userData.rotationSpeed = planet.target === "jupiter" || planet.target === "saturn" ? 0.0014 : 0.0009;
      planetField.add(mesh);
      planetMeshes.push(mesh);
      nightMaterials.push({ material, opacity: planet.opacity });
      disposableTextures.push(texture);
      disposableMaterials.push(material);

      if (planet.ring) {
        const ringGeometry = new THREE.RingGeometry(1.35, 2.12, 48);
        const ringMaterial = new THREE.MeshBasicMaterial({
          color: 0xcdbb8f,
          depthWrite: false,
          opacity: 0,
          side: THREE.DoubleSide,
          transparent: true,
        });
        const ring = new THREE.Mesh(ringGeometry, ringMaterial);
        ring.rotation.x = THREE.MathUtils.degToRad(68);
        ring.rotation.z = THREE.MathUtils.degToRad(-18);
        mesh.add(ring);
        nightMaterials.push({ material: ringMaterial, opacity: 0.48 });
        disposableGeometries.push(ringGeometry);
        disposableMaterials.push(ringMaterial);
      }
    });

    const globeBodyGeometry = new THREE.SphereGeometry(1.8, 48, 24);
    const globeBodyMaterial = new THREE.ShaderMaterial({
      depthWrite: false,
      fragmentShader: `
        uniform vec3 innerColor;
        uniform vec3 rimColor;
        uniform float innerAlpha;
        uniform float rimAlpha;
        varying vec3 vNormal;
        varying vec3 vViewDirection;

        void main() {
          float facing = abs(dot(normalize(vNormal), normalize(vViewDirection)));
          float rim = pow(1.0 - facing, 1.95);
          float center = smoothstep(0.12, 0.95, facing);
          vec3 color = mix(innerColor, rimColor, rim * 0.7);
          float alpha = innerAlpha * center + rimAlpha * rim;
          gl_FragColor = vec4(color, alpha);
        }
      `,
      transparent: true,
      uniforms: {
        innerAlpha: { value: 0.24 },
        innerColor: { value: new THREE.Color(0x1f6fa4) },
        rimAlpha: { value: 0.44 },
        rimColor: { value: new THREE.Color(0x78cfff) },
      },
      vertexShader: `
        varying vec3 vNormal;
        varying vec3 vViewDirection;

        void main() {
          vec4 worldPosition = modelMatrix * vec4(position, 1.0);
          vNormal = normalize(mat3(modelMatrix) * normal);
          vViewDirection = normalize(cameraPosition - worldPosition.xyz);
          gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
      `,
    });
    const globeBody = new THREE.Mesh(globeBodyGeometry, globeBodyMaterial);
    disposableGeometries.push(globeBodyGeometry);
    disposableMaterials.push(globeBodyMaterial);
    globeSpin.add(globeBody);

    const earthSurfaceGeometry = new THREE.SphereGeometry(1.807, 64, 32);
    const earthSurfaceMaterial = new THREE.MeshBasicMaterial({
      depthWrite: false,
      map: earthSurfaceMap,
      opacity: 0.72,
      transparent: true,
    });
    const earthSurface = new THREE.Mesh(earthSurfaceGeometry, earthSurfaceMaterial);
    earthSurface.renderOrder = 0.8;
    disposableGeometries.push(earthSurfaceGeometry);
    disposableMaterials.push(earthSurfaceMaterial);
    globeSpin.add(earthSurface);

    const countriesGeometry = new THREE.SphereGeometry(1.815, 48, 24);
    const countriesMaterial = new THREE.MeshBasicMaterial({
      depthWrite: false,
      map: countriesMap,
      transparent: true,
    });
    const countries = new THREE.Mesh(countriesGeometry, countriesMaterial);
    disposableGeometries.push(countriesGeometry);
    disposableMaterials.push(countriesMaterial);
    globeSpin.add(countries);

    const cloudGeometry = new THREE.SphereGeometry(1.842, 64, 32);
    const cloudMaterial = new THREE.MeshBasicMaterial({
      depthWrite: false,
      map: cloudMap,
      opacity: 0.48,
      transparent: true,
    });
    const clouds = new THREE.Mesh(cloudGeometry, cloudMaterial);
    clouds.renderOrder = 2;
    disposableGeometries.push(cloudGeometry);
    disposableMaterials.push(cloudMaterial);
    globeSpin.add(clouds);

    const atmosphereGlowGeometry = new THREE.SphereGeometry(1.862, 64, 32);
    const atmosphereGlowMaterial = new THREE.ShaderMaterial({
      blending: THREE.AdditiveBlending,
      depthWrite: false,
      fragmentShader: `
        uniform vec3 color;
        varying vec3 vNormal;
        varying vec3 vViewDirection;

        void main() {
          float facing = max(dot(normalize(vNormal), normalize(vViewDirection)), 0.0);
          float rim = pow(1.0 - facing, 2.7);
          float haze = pow(1.0 - facing, 1.45) * 0.032;
          gl_FragColor = vec4(color, rim * 0.12 + haze);
        }
      `,
      transparent: true,
      uniforms: {
        color: { value: new THREE.Color(0x8ed7ff) },
      },
      vertexShader: `
        varying vec3 vNormal;
        varying vec3 vViewDirection;

        void main() {
          vec4 worldPosition = modelMatrix * vec4(position, 1.0);
          vNormal = normalize(mat3(modelMatrix) * normal);
          vViewDirection = normalize(cameraPosition - worldPosition.xyz);
          gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
        }
      `,
    });
    const atmosphereGlow = new THREE.Mesh(atmosphereGlowGeometry, atmosphereGlowMaterial);
    atmosphereGlow.renderOrder = 1.6;
    disposableGeometries.push(atmosphereGlowGeometry);
    disposableMaterials.push(atmosphereGlowMaterial);
    globeSpin.add(atmosphereGlow);

    const stormField = new THREE.Group();
    const stormGeometry = new THREE.PlaneGeometry(1, 1, 1, 1);
    disposableGeometries.push(stormGeometry);
    globeSpin.add(stormField);

    for (let index = 0; index < atmosphericStorms.count; index += 1) {
      const tropicalBias = Math.sin((seededUnit(index + 40) - 0.5) * Math.PI) * 18;
      const latitude = tropicalBias + (seededUnit(index + 70) - 0.5) * 44;
      const longitude = seededUnit(index + 100) * 360 - 180;
      const normal = earthSurfaceNormal(latitude, longitude).normalize();
      const stormMaterial = new THREE.MeshBasicMaterial({
        depthWrite: false,
        map: stormMap,
        opacity: 0,
        side: THREE.DoubleSide,
        transparent: true,
      });
      const lightningMaterial = new THREE.MeshBasicMaterial({
        blending: THREE.AdditiveBlending,
        depthWrite: false,
        map: lightningMap,
        opacity: 0,
        side: THREE.DoubleSide,
        transparent: true,
      });
      const storm = new THREE.Mesh(stormGeometry, stormMaterial);
      const lightning = new THREE.Mesh(stormGeometry, lightningMaterial);
      const stormScale = 0.34 + seededUnit(index + 130) * 0.42;
      const aspect = 0.62 + seededUnit(index + 160) * 0.38;
      const roll = seededUnit(index + 190) * Math.PI * 2;

      storm.position.copy(normal).multiplyScalar(atmosphericStorms.radius);
      storm.quaternion.setFromUnitVectors(zAxis, normal);
      storm.rotateZ(roll);
      storm.scale.set(stormScale, stormScale * aspect, 1);
      storm.renderOrder = 3;

      lightning.position.copy(normal).multiplyScalar(atmosphericStorms.lightningRadius);
      lightning.quaternion.copy(storm.quaternion);
      lightning.scale.set(stormScale * 0.72, stormScale * 0.72 * aspect, 1);
      lightning.renderOrder = 4;

      stormField.add(storm);
      stormField.add(lightning);
      stormSystems.push({
        baseOpacity: 0.34 + seededUnit(index + 220) * 0.18,
        flashPeriod: atmosphericStorms.flashPeriodMin + seededUnit(index + 250) * atmosphericStorms.flashPeriodRange,
        flashPhase: seededUnit(index + 280),
        flashStrength:
          atmosphericStorms.flashStrengthMin + seededUnit(index + 310) * atmosphericStorms.flashStrengthRange,
        lightning,
        lightningMaterial,
        material: stormMaterial,
        storm,
      });
      disposableMaterials.push(stormMaterial, lightningMaterial);
    }

    const iss = new THREE.Group();
    iss.visible = false;
    const issMaterials = [];
    const issBodyMaterial = new THREE.MeshBasicMaterial({
      color: 0xd9dedf,
      opacity: 0,
      transparent: true,
    });
    const issDarkMaterial = new THREE.MeshBasicMaterial({
      color: 0x626b70,
      opacity: 0,
      transparent: true,
    });
    const issSolarMaterial = new THREE.MeshBasicMaterial({
      color: 0x23456b,
      opacity: 0,
      transparent: true,
    });
    const issTrussGeometry = new THREE.BoxGeometry(0.34, 0.018, 0.018);
    const issModuleGeometry = new THREE.BoxGeometry(0.06, 0.035, 0.035);
    const issNodeGeometry = new THREE.BoxGeometry(0.028, 0.028, 0.028);
    const issPanelGeometry = new THREE.BoxGeometry(0.16, 0.004, 0.07);
    const issTruss = new THREE.Mesh(issTrussGeometry, issDarkMaterial);
    iss.add(issTruss);
    [-0.07, 0, 0.07].forEach((x) => {
      const module = new THREE.Mesh(issModuleGeometry, issBodyMaterial);
      module.position.x = x;
      iss.add(module);
    });
    [-0.145, 0.145].forEach((x) => {
      const node = new THREE.Mesh(issNodeGeometry, issDarkMaterial);
      node.position.x = x;
      iss.add(node);
    });
    [-1, 1].forEach((side) => {
      [-0.11, 0.11].forEach((x) => {
        const panel = new THREE.Mesh(issPanelGeometry, issSolarMaterial);
        panel.position.set(x, side * 0.065, 0);
        panel.rotation.z = side * THREE.MathUtils.degToRad(4);
        iss.add(panel);
      });
    });
    iss.scale.setScalar(0.52);
    rocketField.add(iss);
    issMaterials.push(issBodyMaterial, issDarkMaterial, issSolarMaterial);
    disposableGeometries.push(issTrussGeometry, issModuleGeometry, issNodeGeometry, issPanelGeometry);
    disposableMaterials.push(issBodyMaterial, issDarkMaterial, issSolarMaterial);

    const rocket = new THREE.Group();
    rocket.visible = false;
    const rocketScale = 0.82;
    const rocketUpperStack = new THREE.Group();
    const rocketCoreStage = new THREE.Group();
    const rocketCoreDebris = new THREE.Group();
    const rocketBoosterStages = [];
    rocketCoreDebris.visible = false;
    rocketCoreDebris.scale.setScalar(rocketScale);
    rocketField.add(rocketCoreDebris);
    rocket.add(rocketCoreStage);
    rocket.add(rocketUpperStack);

    const rocketBodyGeometry = new THREE.CylinderGeometry(0.032, 0.04, 0.46, 18);
    const rocketBodyMaterial = new THREE.MeshBasicMaterial({
      color: 0xf1f2eb,
      opacity: 0,
      transparent: true,
    });
    const rocketBody = new THREE.Mesh(rocketBodyGeometry, rocketBodyMaterial);
    rocketCoreStage.add(rocketBody);

    const rocketUpperStageGeometry = new THREE.CylinderGeometry(0.024, 0.031, 0.18, 18);
    const rocketUpperStageMaterial = new THREE.MeshBasicMaterial({
      color: 0xe8e9e1,
      opacity: 0,
      transparent: true,
    });
    const rocketUpperStage = new THREE.Mesh(rocketUpperStageGeometry, rocketUpperStageMaterial);
    rocketUpperStage.position.y = 0.315;
    rocketUpperStack.add(rocketUpperStage);

    const rocketFairingGeometry = new THREE.ConeGeometry(0.027, 0.12, 18);
    const rocketFairingMaterial = new THREE.MeshBasicMaterial({
      color: 0xf6f6ef,
      opacity: 0,
      transparent: true,
    });
    const rocketFairing = new THREE.Mesh(rocketFairingGeometry, rocketFairingMaterial);
    rocketFairing.position.y = 0.465;
    rocketUpperStack.add(rocketFairing);

    const rocketBandGeometry = new THREE.CylinderGeometry(0.041, 0.041, 0.018, 18);
    const rocketBandMaterial = new THREE.MeshBasicMaterial({
      color: 0x202329,
      opacity: 0,
      transparent: true,
    });
    [-0.18, 0.085].forEach((y) => {
      const band = new THREE.Mesh(rocketBandGeometry, rocketBandMaterial);
      band.position.y = y;
      rocketCoreStage.add(band);
    });
    const upperInterstageBand = new THREE.Mesh(rocketBandGeometry, rocketBandMaterial);
    upperInterstageBand.position.y = 0.225;
    rocketUpperStack.add(upperInterstageBand);

    const rocketStripeGeometry = new THREE.BoxGeometry(0.006, 0.37, 0.003);
    const rocketStripeMaterial = new THREE.MeshBasicMaterial({
      color: 0x4e575d,
      opacity: 0,
      transparent: true,
    });
    [0, Math.PI].forEach((angle) => {
      const stripe = new THREE.Mesh(rocketStripeGeometry, rocketStripeMaterial);
      stripe.position.set(Math.sin(angle) * 0.041, -0.015, Math.cos(angle) * 0.041);
      stripe.rotation.y = angle;
      rocketCoreStage.add(stripe);
    });

    const rocketBoosterGeometry = new THREE.CylinderGeometry(0.016, 0.019, 0.34, 14);
    const rocketBoosterMaterial = new THREE.MeshBasicMaterial({
      color: 0xdfe1d8,
      opacity: 0,
      transparent: true,
    });
    const rocketBoosterCapGeometry = new THREE.ConeGeometry(0.017, 0.05, 14);
    const rocketBoosterCapMaterial = new THREE.MeshBasicMaterial({
      color: 0xf2f2ea,
      opacity: 0,
      transparent: true,
    });
    const rocketNozzleGeometry = new THREE.ConeGeometry(0.018, 0.055, 14);
    const rocketNozzleMaterial = new THREE.MeshBasicMaterial({
      color: 0x25221f,
      opacity: 0,
      transparent: true,
    });
    [-1, 1].forEach((side) => {
      const boosterStage = new THREE.Group();
      boosterStage.visible = false;
      boosterStage.scale.setScalar(rocketScale);
      boosterStage.userData.side = side;
      rocketBoosterStages.push(boosterStage);
      rocketField.add(boosterStage);

      const booster = new THREE.Mesh(rocketBoosterGeometry, rocketBoosterMaterial);
      boosterStage.add(booster);

      const cap = new THREE.Mesh(rocketBoosterCapGeometry, rocketBoosterCapMaterial);
      cap.position.y = 0.195;
      boosterStage.add(cap);

      const nozzle = new THREE.Mesh(rocketNozzleGeometry, rocketNozzleMaterial);
      nozzle.position.y = -0.197;
      nozzle.rotation.x = Math.PI;
      boosterStage.add(nozzle);
    });

    const rocketEngineGeometry = new THREE.ConeGeometry(0.028, 0.07, 16);
    const rocketEngine = new THREE.Mesh(rocketEngineGeometry, rocketNozzleMaterial);
    rocketEngine.position.y = -0.265;
    rocketEngine.rotation.x = Math.PI;
    rocketCoreStage.add(rocketEngine);

    const coreDebrisBody = new THREE.Mesh(rocketBodyGeometry, rocketBodyMaterial);
    rocketCoreDebris.add(coreDebrisBody);
    [-0.18, 0.085].forEach((y) => {
      const band = new THREE.Mesh(rocketBandGeometry, rocketBandMaterial);
      band.position.y = y;
      rocketCoreDebris.add(band);
    });
    [0, Math.PI].forEach((angle) => {
      const stripe = new THREE.Mesh(rocketStripeGeometry, rocketStripeMaterial);
      stripe.position.set(Math.sin(angle) * 0.041, -0.015, Math.cos(angle) * 0.041);
      stripe.rotation.y = angle;
      rocketCoreDebris.add(stripe);
    });
    const coreDebrisEngine = new THREE.Mesh(rocketEngineGeometry, rocketNozzleMaterial);
    coreDebrisEngine.position.y = -0.265;
    coreDebrisEngine.rotation.x = Math.PI;
    rocketCoreDebris.add(coreDebrisEngine);

    const rocketFlameGeometry = new THREE.ConeGeometry(0.024, 0.16, 16);
    const rocketFlameMaterial = new THREE.MeshBasicMaterial({
      color: 0xf0b35a,
      opacity: 0,
      transparent: true,
    });
    const rocketFlame = new THREE.Mesh(rocketFlameGeometry, rocketFlameMaterial);
    rocketFlame.position.y = -0.36;
    rocketFlame.rotation.x = Math.PI;
    rocket.add(rocketFlame);

    rocket.scale.setScalar(rocketScale);
    rocketField.add(rocket);
    rocketMaterials.push(
      rocketBodyMaterial,
      rocketUpperStageMaterial,
      rocketFairingMaterial,
      rocketBandMaterial,
      rocketStripeMaterial,
      rocketBoosterMaterial,
      rocketBoosterCapMaterial,
      rocketNozzleMaterial
    );
    disposableGeometries.push(
      rocketBodyGeometry,
      rocketUpperStageGeometry,
      rocketFairingGeometry,
      rocketBandGeometry,
      rocketStripeGeometry,
      rocketBoosterGeometry,
      rocketBoosterCapGeometry,
      rocketNozzleGeometry,
      rocketEngineGeometry,
      rocketFlameGeometry
    );
    disposableMaterials.push(
      rocketBodyMaterial,
      rocketUpperStageMaterial,
      rocketFairingMaterial,
      rocketBandMaterial,
      rocketStripeMaterial,
      rocketBoosterMaterial,
      rocketBoosterCapMaterial,
      rocketNozzleMaterial,
      rocketFlameMaterial
    );

    const panelWidth = 4.0;
    const panelHeight = 2.26;
    const radius = (items.length * panelWidth) / Math.PI / 2;

    items.forEach((item, index) => {
      const theta = (index / items.length) * Math.PI * 2;
      const material = new THREE.MeshBasicMaterial({
        map: index === 0 ? paneOpenTextures[index] : paneTextures[index],
        opacity: index === 0 ? 1 : 0.58,
        side: THREE.DoubleSide,
        transparent: true,
      });
      const geometry = new THREE.PlaneGeometry(panelWidth, panelHeight, 3, 1);
      const plane = new THREE.Mesh(geometry, material);

      plane.position.set(Math.sin(theta) * radius, 0.75, Math.cos(theta) * radius);
      plane.rotation.y = theta;
      plane.userData.baseX = plane.position.x;
      plane.userData.baseY = plane.position.y;
      plane.userData.baseZ = plane.position.z;
      plane.userData.index = index;
      plane.userData.theta = theta;
      rotatePlanes.add(plane);
      panels.push(plane);
      disposableGeometries.push(geometry);
      disposableMaterials.push(material);
    });

    function setPaneOverlay(index, open) {
      const panel = panels[index];
      if (!panel) {
        return;
      }

      panel.material.map = open ? paneOpenTextures[index] : paneTextures[index];
      panel.material.needsUpdate = true;
    }

    function resize() {
      const rootRect = root.getBoundingClientRect();
      const canvasRect = canvas.getBoundingClientRect();
      const viewWidth = Math.max(1, rootRect.width);
      const viewHeight = Math.max(1, rootRect.height);
      const width = Math.max(1, canvasRect.width);
      const height = Math.max(1, canvasRect.height);
      const offsetX = canvasRect.left - rootRect.left;
      const offsetY = canvasRect.top - rootRect.top;

      camera.setViewOffset(viewWidth, viewHeight, offsetX, offsetY, width, height);
      camera.updateProjectionMatrix();
      renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 1.75));
      renderer.setSize(width, height, false);
      setActiveCity(root, state.animating ? state.pending : state.selected, 0);
    }

    function selectPane(index) {
      if (state.animating || index === state.selected) {
        return;
      }

      const distance = shortestRotationDistance(
        rotatePlanes.rotation.y,
        -panels[index].userData.theta,
        state.lastDirection
      );
      const target = rotatePlanes.rotation.y + distance;
      setPaneOverlay(state.selected, false);
      root.classList.add("heinz-world-spinning");
      root.classList.remove("heinz-world-panel-open");
      state.animating = true;
      state.duration = reducedMotion ? 1 : rotationDuration(distance);
      state.from = rotatePlanes.rotation.y;
      state.lastDirection = Math.sign(distance) || state.lastDirection;
      state.pending = index;
      state.run += 1;
      state.idleResumeAt = Infinity;
      state.started = performance.now();
      state.target = target;
      setActiveCity(root, index, state.duration);
    }

    function pointerToCanvas(event) {
      const rootRect = root.getBoundingClientRect();
      if (
        event.clientX < rootRect.left ||
        event.clientX > rootRect.right ||
        event.clientY < rootRect.top ||
        event.clientY > rootRect.bottom
      ) {
        return false;
      }

      const rect = canvas.getBoundingClientRect();
      pointer.x = ((event.clientX - rect.left) / rect.width) * 2 - 1;
      pointer.y = -(((event.clientY - rect.top) / rect.height) * 2 - 1);
      return true;
    }

    handlePointerMove = (event) => {
      if (!pointerToCanvas(event)) {
        canvas.classList.remove("is-clickable");
        return;
      }

      raycaster.setFromCamera(pointer, camera);
      canvas.classList.toggle("is-clickable", raycaster.intersectObjects(panels, false).length > 0);
    };

    handlePointerLeave = () => {
      canvas.classList.remove("is-clickable");
    };

    handleClick = (event) => {
      if (!pointerToCanvas(event)) {
        return;
      }

      raycaster.setFromCamera(pointer, camera);
      const hit = raycaster.intersectObjects(panels, false)[0];
      if (hit) {
        selectPane(hit.object.userData.index);
      }
    };

    canvas.addEventListener("pointermove", handlePointerMove);
    canvas.addEventListener("pointerleave", handlePointerLeave);
    canvas.addEventListener("click", handleClick);

    const earthWorldPosition = new THREE.Vector3();
    const cameraWorldPosition = new THREE.Vector3();
    const stormWorldPosition = new THREE.Vector3();
    const stormNormalWorld = new THREE.Vector3();
    const stormViewDirection = new THREE.Vector3();

    function rocketTargetsForFrame(frame) {
      const frameMoonTime = scaledTime(celestialStartTime, celestialStartFrame, frame, celestialClock.moonScale);
      const framePlanetTime = scaledTime(celestialStartTime, celestialStartFrame, frame, celestialClock.planetScale);
      const frameEarthPosition = heliocentricPlanetPosition("earth", framePlanetTime);

      return {
        mars: pitchToRocketFieldPosition(
          planetScenePosition(heliocentricPlanetPosition("mars", framePlanetTime), frameEarthPosition)
        ),
        moon: pitchToRocketFieldPosition(rocketMoonPosition(moonNodeAt(frameMoonTime), moonArgumentAt(frameMoonTime))),
      };
    }

    function setCelestialPositions(nowFrame) {
      const earthTime = scaledTime(celestialStartTime, celestialStartFrame, nowFrame, celestialClock.earthScale);
      const planetTime = scaledTime(celestialStartTime, celestialStartFrame, nowFrame, celestialClock.planetScale);
      const nightFactor = localNightFactor(earthTime);
      nightRoot.style.setProperty("--heinz-world-night", nightFactor.toFixed(3));
      globeSpin.rotation.y = earthRotationAt(earthTime);
      const moonTime = scaledTime(celestialStartTime, celestialStartFrame, nowFrame, celestialClock.moonScale);
      moonOrbitNode.rotation.y = moonNodeAt(moonTime);
      moonOrbitSpin.rotation.y = moonArgumentAt(moonTime);
      galacticField.rotation.y = -earthRotationAt(earthTime) * 0.18;
      nightMaterials.forEach((item) => {
        item.material.opacity = item.opacity * nightFactor;
      });
      clouds.rotation.y = daysSinceJ2000(earthTime) * Math.PI * 2 * 0.18;
      stormField.rotation.y = clouds.rotation.y + (nowFrame - celestialStartFrame) * atmosphericStorms.rotationDrift;
      globeSpin.getWorldPosition(earthWorldPosition);
      camera.getWorldPosition(cameraWorldPosition);
      const weatherClock = celestialStartTime + (nowFrame - celestialStartFrame);
      stormSystems.forEach((system) => {
        system.storm.getWorldPosition(stormWorldPosition);
        stormNormalWorld.copy(stormWorldPosition).sub(earthWorldPosition).normalize();
        stormViewDirection.copy(cameraWorldPosition).sub(earthWorldPosition).normalize();
        const facing = stormNormalWorld.dot(stormViewDirection);
        const visibleSide = THREE.MathUtils.smoothstep(facing, -0.08, 0.38);
        const flashCycle = fract(weatherClock / system.flashPeriod + system.flashPhase);
        const flashOne = Math.exp(-Math.pow((flashCycle - 0.018) / 0.022, 2));
        const flashTwo = Math.exp(-Math.pow((flashCycle - 0.07) / 0.028, 2)) * 0.72;
        const flashThree = Math.exp(-Math.pow((flashCycle - 0.13) / 0.034, 2)) * 0.44;
        const flash = Math.min(1, Math.max(flashOne, flashTwo, flashThree));

        system.material.opacity = system.baseOpacity * visibleSide * (0.72 + nightFactor * 0.28);
        system.lightningMaterial.opacity =
          Math.min(1, system.flashStrength * flash * visibleSide * (0.35 + nightFactor * 0.9));
      });
      asteroidField.rotation.y = (nowFrame - celestialStartFrame) * asteroidBelt.rotationSpeed;
      const issPass = fract((nowFrame - celestialStartFrame) / issOrbit.period + issOrbit.phase);
      const issPosition = issScenePosition(issPass);
      const issVelocity = issScenePosition(fract(issPass + 0.004)).sub(issPosition).normalize();
      const issOpacity = issOrbit.opacity * (0.72 + nightFactor * 0.28);
      iss.visible = true;
      iss.position.copy(issPosition);
      iss.quaternion.setFromUnitVectors(new THREE.Vector3(1, 0, 0), issVelocity);
      iss.rotateY(Math.sin(issPass * Math.PI * 2) * 0.18);
      issMaterials.forEach((material) => {
        material.opacity = issOpacity;
      });
      const earthPosition = heliocentricPlanetPosition("earth", planetTime);
      const rocketTargets = rocketTargetsForFrame(nowFrame);
      const rocketState = rocketFlightState(nowFrame, celestialStartFrame, celestialStartTime);

      if (rocketState) {
        const earthRotation = globeSpin.rotation.y;
        if (activeRocketMissionIndex !== rocketState.missionIndex) {
          const transferSegment = rocketState.profile.segments.find((segment) => segment.mode.endsWith("Transfer"));
          const transferArrivalTargets = rocketTargetsForFrame(
            rocketState.missionStartFrame +
              (transferSegment ? transferSegment.end : 0.5) * rocketMission.activeWindow * rocketMission.period
          );
          activeRocketMissionIndex = rocketState.missionIndex;
          activeRocketRoute = rocketRouteForMission(rocketState.missionIndex, earthRotation);
          activeRocketTransferTargets = {
            marsTransfer: transferArrivalTargets.mars,
            moonTransfer: transferArrivalTargets.moon,
          };
        }
        const missionTargets = {
          mars: rocketTargets.mars,
          moon: rocketTargets.moon,
          ...(activeRocketTransferTargets || {}),
        };
        const position = rocketScenePosition(
          rocketState.pass,
          rocketState.mode,
          activeRocketRoute,
          earthRotation,
          missionTargets
        );
        let velocity = position
          .clone()
          .sub(
            rocketScenePosition(
              Math.max(0, rocketState.pass - 0.012),
              rocketState.mode,
              activeRocketRoute,
              earthRotation,
              missionTargets
            )
          );

        if (velocity.lengthSq() < 0.000001) {
          velocity = rocketScenePosition(
            Math.min(1, rocketState.pass + 0.012),
            rocketState.mode,
            activeRocketRoute,
            earthRotation,
            missionTargets
          ).sub(position);
        }

        velocity.normalize();
        const flicker = 0.72 + fract(Math.sin(nowFrame * 0.048) * 9187.31) * 0.38;
        const opacity = rocketMission.opacity * rocketState.visibility * (0.7 + nightFactor * 0.3);
        const isLaunch = rocketState.mode === "launch";
        const isCruise = rocketState.mode !== "launch" && rocketState.mode !== "land";
        const isUpperStageOnly = !isLaunch;
        const isBurning = isLaunch || (isCruise && (rocketState.pass < 0.12 || rocketState.pass > 0.88));
        const boosterDetachPass = 0.32;
        const coreDetachPass = 0.68;
        const boosterDebrisEndPass = 0.58;
        const coreDebrisEndPass = 0.88;
        const boosterSeparation = isLaunch ? THREE.MathUtils.smoothstep(rocketState.pass, 0.28, 0.44) : 0;
        const coreSeparation = isLaunch ? THREE.MathUtils.smoothstep(rocketState.pass, 0.62, 0.78) : 0;
        const rocketDirection = isLaunch
          ? rocketLaunchDirection(rocketState.pass, activeRocketRoute, earthRotation, velocity)
          : velocity;
        const rocketOrientation = new THREE.Quaternion().setFromUnitVectors(yAxis, rocketDirection);

        rocket.visible = true;
        rocket.position.copy(position);
        rocket.quaternion.copy(rocketOrientation);
        rocketUpperStack.visible = true;
        rocketUpperStack.position.set(0, isUpperStageOnly ? -0.18 : coreSeparation * 0.035, 0);
        rocketUpperStack.rotation.z = isUpperStageOnly ? 0 : coreSeparation * 0.045;
        rocketCoreStage.visible = isLaunch && rocketState.pass < 0.78;
        rocketCoreStage.position.set(0, -coreSeparation * 0.28, coreSeparation * 0.025);
        rocketCoreStage.rotation.z = -coreSeparation * 0.18;
        rocketBoosterStages.forEach((stage) => {
          const side = stage.userData.side;
          stage.visible = isLaunch && rocketState.pass < boosterDebrisEndPass;

          if (!stage.visible) {
            return;
          }

          if (rocketState.pass < boosterDetachPass) {
            const attachedOffset = new THREE.Vector3(side * 0.052, -0.055, 0)
              .multiplyScalar(rocketScale)
              .applyQuaternion(rocketOrientation);
            stage.position.copy(position).add(attachedOffset);
            stage.quaternion.copy(rocketOrientation);
            return;
          }

          const separationPass = boosterDetachPass;
          const separationPosition = rocketScenePosition(
            separationPass,
            "launch",
            activeRocketRoute,
            earthRotation,
            missionTargets
          );
          const separationVelocity = rocketScenePosition(
            separationPass + 0.012,
            "launch",
            activeRocketRoute,
            earthRotation,
            missionTargets
          )
            .sub(separationPosition)
            .normalize();
          const separationDirection = rocketLaunchDirection(
            separationPass,
            activeRocketRoute,
            earthRotation,
            separationVelocity
          );
          const separationOrientation = new THREE.Quaternion().setFromUnitVectors(yAxis, separationDirection);
          const drift = THREE.MathUtils.smoothstep(rocketState.pass, boosterDetachPass, boosterDebrisEndPass);
          const detachedOffset = new THREE.Vector3(
            side * (0.052 + drift * 0.54),
            -0.055 - drift * 0.72,
            drift * (0.12 + side * 0.06)
          )
            .multiplyScalar(rocketScale)
            .applyQuaternion(separationOrientation);
          stage.position.copy(separationPosition).add(detachedOffset);
          stage.quaternion.copy(separationOrientation);
          stage.rotateX(drift * 0.3);
          stage.rotateZ(side * drift * 1.12);
        });
        rocketCoreDebris.visible = isLaunch && rocketState.pass >= coreDetachPass && rocketState.pass < coreDebrisEndPass;
        if (rocketCoreDebris.visible) {
          const separationPass = coreDetachPass;
          const separationPosition = rocketScenePosition(
            separationPass,
            "launch",
            activeRocketRoute,
            earthRotation,
            missionTargets
          );
          const separationVelocity = rocketScenePosition(
            separationPass + 0.012,
            "launch",
            activeRocketRoute,
            earthRotation,
            missionTargets
          )
            .sub(separationPosition)
            .normalize();
          const separationDirection = rocketLaunchDirection(
            separationPass,
            activeRocketRoute,
            earthRotation,
            separationVelocity
          );
          const separationOrientation = new THREE.Quaternion().setFromUnitVectors(yAxis, separationDirection);
          const drift = THREE.MathUtils.smoothstep(rocketState.pass, coreDetachPass, coreDebrisEndPass);
          const detachedOffset = new THREE.Vector3(-0.14 * drift, -0.82 * drift, -0.14 * drift)
            .multiplyScalar(rocketScale)
            .applyQuaternion(separationOrientation);
          rocketCoreDebris.position.copy(separationPosition).add(detachedOffset);
          rocketCoreDebris.quaternion.copy(separationOrientation);
          rocketCoreDebris.rotateX(drift * 0.46);
          rocketCoreDebris.rotateZ(-drift * 0.52);
        }
        rocketMaterials.forEach((material) => {
          material.opacity = opacity;
        });
        rocketFlame.position.y = isUpperStageOnly ? 0.08 : -0.36 + coreSeparation * 0.5;
        rocketFlameMaterial.opacity =
          opacity *
          (isBurning
            ? isLaunch
              ? THREE.MathUtils.lerp(0.92, 0.36, Math.max(coreSeparation, boosterSeparation * 0.45))
              : 0.2
            : 0.025) *
          flicker;
        rocketFlame.scale.set(
          0.72 + flicker * 0.18 - coreSeparation * 0.2 - (isUpperStageOnly ? 0.26 : 0),
          0.95 + flicker * 0.34 - coreSeparation * 0.22 - (isUpperStageOnly ? 0.34 : 0),
          0.72 + flicker * 0.18 - coreSeparation * 0.2 - (isUpperStageOnly ? 0.26 : 0)
        );
      } else {
        activeRocketMissionIndex = -1;
        activeRocketRoute = undefined;
        activeRocketTransferTargets = undefined;
        rocket.visible = false;
        rocketUpperStack.position.set(0, 0, 0);
        rocketUpperStack.rotation.set(0, 0, 0);
        rocketCoreStage.position.set(0, 0, 0);
        rocketCoreStage.rotation.set(0, 0, 0);
        rocketCoreDebris.visible = false;
        rocketCoreDebris.position.set(0, 0, 0);
        rocketCoreDebris.rotation.set(0, 0, 0);
        rocketBoosterStages.forEach((stage) => {
          stage.visible = false;
          stage.position.set(0, 0, 0);
          stage.rotation.set(0, 0, 0);
        });
        rocketMaterials.forEach((material) => {
          material.opacity = 0;
        });
        rocketFlame.position.y = -0.36;
        rocketFlameMaterial.opacity = 0;
      }
      cometSprites.forEach((sprite) => {
        const comet = sprite.userData.comet;
        const stateNow = cometPass(comet, nowFrame, celestialStartFrame);

        if (!stateNow) {
          sprite.material.opacity = 0;
          return;
        }

        const position = cometScenePosition(comet, stateNow.pass);
        const previous = cometScenePosition(comet, Math.max(0, stateNow.pass - 0.012));
        const velocity = position.clone().sub(previous);
        sprite.position.copy(position);
        sprite.material.rotation = Math.atan2(velocity.y, velocity.x);
        sprite.material.opacity = comet.opacity * stateNow.brightness * nightFactor;
        sprite.scale.set(
          comet.length * (0.86 + stateNow.brightness * 0.28),
          comet.width * (0.84 + stateNow.brightness * 0.35),
          1
        );
      });
      planetMeshes.forEach((mesh) => {
        const planetPosition = heliocentricPlanetPosition(mesh.userData.planetTarget, planetTime);
        mesh.position.copy(planetScenePosition(planetPosition, earthPosition));
        mesh.rotation.y += mesh.userData.rotationSpeed;
      });
    }

    function render() {
      if (disposed) {
        return;
      }

      const now = performance.now();
      if (!reducedMotion) {
        setCelestialPositions(now);
      }

      if (state.animating) {
        const progress = Math.min(1, (now - state.started) / state.duration);
        rotatePlanes.rotation.y = state.from + (state.target - state.from) * easeInOut(progress);
        state.animating = progress !== 1;
        if (!state.animating) {
          const completedRun = state.run;
          state.selected = state.pending;
          setPaneOverlay(state.selected, true);
          updatePanelCopy(root, items[state.selected]);
          root.classList.remove("heinz-world-spinning");
          state.idleResumeAt = now + tileIdleMotion.resumeDelay;
          if (panelOpenFrame) {
            cancelAnimationFrame(panelOpenFrame);
          }
          panelOpenFrame = requestAnimationFrame(() => {
            panelOpenFrame = 0;
            if (!disposed && !state.animating && state.run === completedRun) {
              root.classList.add("heinz-world-panel-open");
            }
          });
        }
      }

      panels.forEach((panel, index) => {
        const idleAmount =
          !state.animating && !reducedMotion
            ? THREE.MathUtils.smoothstep(now - state.idleResumeAt, 0, tileIdleMotion.resumeDuration)
            : 0;

        if (idleAmount > 0) {
          const phase = now * tileIdleMotion.speed + index * 0.77;
          const pulse = Math.sin(phase);
          panel.position.x =
            panel.userData.baseX + Math.sin(panel.userData.theta) * pulse * tileIdleMotion.depth * idleAmount;
          panel.position.y = panel.userData.baseY + Math.cos(phase * 0.88) * tileIdleMotion.lift * idleAmount;
          panel.position.z =
            panel.userData.baseZ + Math.cos(panel.userData.theta) * pulse * tileIdleMotion.depth * idleAmount;
          panel.rotation.x = Math.sin(phase * 0.82 + 1.1) * tileIdleMotion.pitch * idleAmount;
        } else {
          panel.position.x = panel.userData.baseX;
          panel.position.y = panel.userData.baseY;
          panel.position.z = panel.userData.baseZ;
          panel.rotation.x = 0;
        }

        const facing = Math.max(0, Math.cos(panel.userData.theta + rotatePlanes.rotation.y));
        panel.material.opacity = 0.38 + facing * 0.62;
      });

      renderer.render(scene, camera);
      animationFrame = requestAnimationFrame(render);
    }

    resize();
    resizeObserver = new ResizeObserver(resize);
    resizeObserver.observe(root);
    buildCityStrip(root, items, selectPane);
    updatePanelCopy(root, items[0]);
    setActiveCity(root, 0);
    setCelestialPositions(celestialStartFrame);
    root.classList.add("heinz-world-ready", "heinz-world-panel-open");
    render();
    return cleanup;
  } catch (error) {
    cleanup();
    throw error;
  }
}

async function init(root) {
  cleanupRoot(root);
  const initToken = Symbol("heinzWorldInit");
  root[initTokenKey] = initToken;

  try {
      const response = await fetch(endpointUrl(root), { headers: { Accept: "text/xml" } });
      if (!response.ok) {
        throw new Error(`Heinz carousel XML returned ${response.status}`);
      }

      const items = parseItems(await response.text());
      if (!items.length) {
        throw new Error("Heinz carousel XML did not include items");
      }

      const cleanup = await initWorld(root, items);
      if (root[initTokenKey] !== initToken) {
        cleanup();
        return;
      }

      root[cleanupKey] = cleanup;
    } catch (error) {
      if (root[initTokenKey] === initToken) {
        root[initTokenKey] = undefined;
      }
      console.error("Heinz world carousel failed", error);
      throw error;
    }
  }

  roots.forEach((root) => {
    init(root);
  });

  window.addEventListener("pagehide", (event) => {
    if (event.persisted) {
      return;
    }

    roots.forEach(cleanupRoot);
  });
