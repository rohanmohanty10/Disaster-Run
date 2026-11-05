#!/usr/bin/env python3
"""Builds the place's static world models (synced into Workspace by Rojo):

  src/map/Course.rbxmx  — the green valley course (floor, grassy slopes, cliffs, bunker, gate)
  src/map/Lobby.rbxmx   — a simple temporary lobby plaza with vault kiosks

Run from the repo root:  python3 tools/build_world.py

Course numbers mirror src/shared/Config/MapConfig.luau (MapService reads the same values to
place cover each round). Both models are plain on purpose; edit them in Studio and save over
these files (right-click → Save to File) when you want to hand-polish them.
"""
import math
import os
import xml.etree.ElementTree as ET

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MAP_DIR = os.path.join(ROOT, "src", "map")

# --- mirror of MapConfig.luau
ORIGIN = (600.0, 0.0, 0.0)
LENGTH = 1200.0
WIDTH = 170.0
WALL_HEIGHT = 60.0

GRASS = (86, 140, 62)
GRASS_DARK = (64, 110, 48)
MOSS_ROCK = (98, 104, 84)
CLIFF = (112, 100, 82)
STONE = (150, 146, 136)
PATH = (176, 150, 112)
WOOD = (110, 78, 50)
LEAVES = (70, 130, 60)
HEDGE = (56, 112, 52)
WHITE = (235, 230, 215)
BARRIER = (56, 189, 248)
SANCTUARY = (80, 255, 140)
GOD = (167, 139, 250)
RUNNER = (56, 189, 248)

MATERIAL = {
    "Grass": 1280, "LeafyGrass": 1284, "Ground": 1360, "Rock": 896, "Slate": 800, "Concrete": 816,
    "Cobblestone": 880, "Marble": 784, "Wood": 512, "WoodPlanks": 528, "Neon": 288,
    "ForceField": 1584, "SmoothPlastic": 272, "Pavement": 836, "Sand": 1296,
}
SHAPE = {"Ball": 0, "Block": 1, "Cylinder": 2}
KEYCODE_E = 101

_ref = 0


def ref():
    global _ref
    _ref += 1
    return f"RBXWORLD{_ref:05d}"


def prop(props, kind, name, text=None):
    el = ET.SubElement(props, kind, {"name": name})
    if text is not None:
        el.text = str(text)
    return el


def rot_y(degrees):
    t = math.radians(degrees)
    c, s = math.cos(t), math.sin(t)
    return [c, 0, s, 0, 1, 0, -s, 0, c]


def rot_z90():
    # Cylinders run along X; this stands them upright (axis along Y).
    return [0, -1, 0, 1, 0, 0, 0, 0, 1]


def item(parent, cls, name):
    it = ET.SubElement(parent, "Item", {"class": cls, "referent": ref()})
    props = ET.SubElement(it, "Properties")
    prop(props, "string", "Name", name)
    return it, props


def part(parent, name, size, pos, color, material, cls="Part", shape="Block", rotation=None,
         transparency=0.0, can_collide=True, can_query=True, cast_shadow=True, extra=None):
    it, props = item(parent, cls, name)
    prop(props, "bool", "Anchored", "true")
    prop(props, "bool", "CanCollide", "true" if can_collide else "false")
    prop(props, "bool", "CanQuery", "true" if can_query else "false")
    prop(props, "bool", "CanTouch", "true")
    prop(props, "bool", "CastShadow", "true" if cast_shadow else "false")
    prop(props, "float", "Transparency", transparency)
    prop(props, "token", "Material", MATERIAL[material])
    r, g, b = color
    prop(props, "Color3uint8", "Color3uint8", 0xFF000000 + (r << 16) + (g << 8) + b)
    if cls == "Part":
        prop(props, "token", "shape", SHAPE[shape])
    prop(props, "token", "TopSurface", 0)
    prop(props, "token", "BottomSurface", 0)
    size_el = prop(props, "Vector3", "size")
    for axis, value in zip("XYZ", size):
        ET.SubElement(size_el, axis).text = repr(float(value))
    cf = prop(props, "CoordinateFrame", "CFrame")
    for axis, value in zip("XYZ", pos):
        ET.SubElement(cf, axis).text = repr(float(value))
    for key, value in zip(["R00", "R01", "R02", "R10", "R11", "R12", "R20", "R21", "R22"], rotation or [1, 0, 0, 0, 1, 0, 0, 0, 1]):
        ET.SubElement(cf, key).text = repr(float(value))
    for kind, key, value in extra or []:
        prop(props, kind, key, value)
    return it


def point_light(parent, color, brightness, range_):
    _, props = item(parent, "PointLight", "Light")
    prop(props, "float", "Brightness", brightness)
    prop(props, "float", "Range", range_)
    c = prop(props, "Color3", "Color")
    for axis, value in zip("RGB", color):
        ET.SubElement(c, axis).text = repr(value / 255)


def prompt(parent, name, action, object_text):
    _, props = item(parent, "ProximityPrompt", name)
    prop(props, "string", "ActionText", action)
    prop(props, "string", "ObjectText", object_text)
    prop(props, "float", "HoldDuration", 0)
    prop(props, "float", "MaxActivationDistance", 12)
    prop(props, "token", "KeyboardKeyCode", KEYCODE_E)
    prop(props, "bool", "RequiresLineOfSight", "false")


def tree(parent, x, ground_y, z, scale=1.0):
    trunk_h = 10 * scale
    part(parent, "TreeTrunk", (trunk_h, 2.2 * scale, 2.2 * scale), (x, ground_y + trunk_h / 2, z), WOOD, "Wood", shape="Cylinder", rotation=rot_z90())
    part(parent, "TreeLeaves", (11 * scale, 11 * scale, 11 * scale), (x, ground_y + trunk_h + 3 * scale, z), LEAVES, "LeafyGrass", shape="Ball")


def save(model_root, filename):
    os.makedirs(MAP_DIR, exist_ok=True)
    root = ET.Element("roblox", {"version": "4"})
    root.append(model_root)
    ET.indent(root, space="\t")
    path = os.path.join(MAP_DIR, filename)
    ET.ElementTree(root).write(path, encoding="utf-8", xml_declaration=False)
    print("wrote", os.path.relpath(path, ROOT))


# ---------------------------------------------------------------- course
def build_course():
    ox, oy, oz = ORIGIN
    model = ET.Element("Item", {"class": "Model", "referent": ref()})
    props = ET.SubElement(model, "Properties")
    prop(props, "string", "Name", "Course")

    center_z = oz - LENGTH / 2 + 30
    full = LENGTH + 120
    part(model, "Floor", (WIDTH, 4, full), (ox, oy - 2, center_z), GRASS, "Grass")
    # A worn dirt path down the middle.
    part(model, "Path", (26, 0.2, full), (ox, oy + 0.05, center_z), PATH, "Ground", can_query=False, cast_shadow=False)

    for side in (-1, 1):
        # Grassy slopes climbing up to the cliffs (they read as valley sides from above).
        slope_depth, slope_h = 22, 14
        part(model, "ValleySlope", (full, slope_h, slope_depth),
             (ox + side * (WIDTH / 2 - slope_depth / 2), oy + slope_h / 2, center_z),
             GRASS_DARK, "Grass", cls="WedgePart", rotation=rot_y(90 * side))
        part(model, "Cliff", (12, WALL_HEIGHT, full), (ox + side * (WIDTH / 2 + 6), oy - 2 + WALL_HEIGHT / 2, center_z), CLIFF, "Rock")
        part(model, "CliffTop", (24, 3, full), (ox + side * (WIDTH / 2 + 12), oy - 2 + WALL_HEIGHT + 1.5, center_z), GRASS, "Grass")

    # Start bunker, barrier and spawn point.
    start_z = oz + 40
    part(model, "BunkerBack", (WIDTH, 30, 6), (ox, oy + 15, start_z + 40), STONE, "Cobblestone")
    part(model, "BunkerRoof", (WIDTH, 2, 46), (ox, oy + 30, start_z + 18), MOSS_ROCK, "Slate")
    part(model, "StartBarrier", (WIDTH, 30, 2), (ox, oy + 15, oz), BARRIER, "ForceField", transparency=0.5)
    part(model, "StartSpawn", (30, 1, 20), (ox, oy + 0.5, start_z + 15), GRASS, "Grass", transparency=1, can_collide=False, can_query=False)

    # Sanctuary gate and finish zone.
    end_z = oz - LENGTH
    for side in (-1, 1):
        part(model, "GatePillar", (8, 40, 8), (ox + side * 30, oy + 20, end_z), WHITE, "Marble")
    part(model, "GateArch", (68, 6, 8), (ox, oy + 43, end_z), WHITE, "Marble")
    part(model, "Sanctuary", (WIDTH, 30, 30), (ox, oy + 15, end_z - 20), SANCTUARY, "ForceField", transparency=0.6, can_collide=False, can_query=False)
    save(model, "Course.rbxmx")


# ---------------------------------------------------------------- lobby
def build_lobby():
    model = ET.Element("Item", {"class": "Model", "referent": ref()})
    props = ET.SubElement(model, "Properties")
    prop(props, "string", "Name", "Lobby")

    size = 160
    top = 1.0  # floor top sits just above the default baseplate
    part(model, "Lawn", (size, 2, size), (0, top - 1, 0), GRASS, "Grass")
    part(model, "Plaza", (2, 70, 70), (0, top + 0.05, 0), STONE, "Pavement", shape="Cylinder", rotation=rot_z90())
    part(model, "PlazaRing", (2.2, 74, 74), (0, top - 0.05, 0), WHITE, "Marble", shape="Cylinder", rotation=rot_z90())

    # Spawn in the middle of the plaza.
    part(model, "LobbySpawn", (12, 1, 12), (0, top + 0.6, 0), WHITE, "Marble", cls="SpawnLocation",
         extra=[("bool", "Neutral", "true"), ("int", "Duration", 0)])

    # Hedges around the edge, with an opening on the +X side toward the valley.
    hedge_h = 5
    half = size / 2 - 2
    part(model, "Hedge", (size, hedge_h, 4), (0, top + hedge_h / 2, half), HEDGE, "LeafyGrass")
    part(model, "Hedge", (size, hedge_h, 4), (0, top + hedge_h / 2, -half), HEDGE, "LeafyGrass")
    part(model, "Hedge", (4, hedge_h, size), (-half, top + hedge_h / 2, 0), HEDGE, "LeafyGrass")
    gap = 30
    side_len = (size - gap) / 2
    for sign in (-1, 1):
        part(model, "Hedge", (4, hedge_h, side_len), (half, top + hedge_h / 2, sign * (gap / 2 + side_len / 2)), HEDGE, "LeafyGrass")

    # Arch over the opening, pointing toward the valley.
    for sign in (-1, 1):
        part(model, "ArchPillar", (4, 22, 4), (half, top + 11, sign * (gap / 2 + 2)), WHITE, "Marble")
    part(model, "ArchTop", (4, 4, gap + 8), (half, top + 24, 0), WHITE, "Marble")
    part(model, "ArchGlow", (1, 1.2, gap + 2), (half - 2.3, top + 22.6, 0), SANCTUARY, "Neon", can_collide=False, can_query=False)

    # Vault kiosks: walk up and press E.
    for name, color, x, z, action, title in (
        ("GodVaultKiosk", GOD, -28, -38, "Open", "God Vault"),
        ("RunnerVaultKiosk", RUNNER, 28, -38, "Open", "Runner Vault"),
    ):
        kiosk = ET.SubElement(model, "Item", {"class": "Model", "referent": ref()})
        kp = ET.SubElement(kiosk, "Properties")
        prop(kp, "string", "Name", name)
        part(kiosk, "Base", (14, 1.5, 14), (x, top + 0.75, z), STONE, "Marble")
        part(kiosk, "Pillar", (4, 12, 4), (x, top + 7.5, z), STONE, "Marble")
        crystal = part(kiosk, "Crystal", (5, 5, 5), (x, top + 16, z), color, "Neon", shape="Ball", can_collide=False)
        point_light(crystal, color, 2, 20)
        prompt(crystal, "OpenVault", action, title)

    # Lamps around the plaza.
    for angle in range(0, 360, 60):
        a = math.radians(angle + 30)
        x, z = math.cos(a) * 44, math.sin(a) * 44
        part(model, "LampPost", (10, 1, 1), (x, top + 5, z), (60, 60, 66), "Concrete", shape="Cylinder", rotation=rot_z90())
        lamp = part(model, "LampLight", (2, 2, 2), (x, top + 10.5, z), (255, 236, 180), "Neon", shape="Ball", can_collide=False)
        point_light(lamp, (255, 230, 170), 1.5, 18)

    # A few trees in the corners.
    for x, z, s in ((-62, 62, 1.2), (-62, -62, 1.0), (62, 62, 1.1), (-40, 66, 0.8), (66, -40, 0.9), (-66, 20, 0.9)):
        tree(model, x, top, z, s)

    save(model, "Lobby.rbxmx")


if __name__ == "__main__":
    build_course()
    build_lobby()
