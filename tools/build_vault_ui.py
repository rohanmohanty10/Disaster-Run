#!/usr/bin/env python3
"""Builds Disaster Run's vault and HUD GUIs from the BasketballGame UI exports.

Run from the repo root:  python3 tools/build_vault_ui.py

Inputs  (references/BasketballGame/UI/):
  Style.rbxmx   -> src/gui/RunnerVault.rbxmx   (Runner Reflex vault)
  Zone.rbxmx    -> src/gui/GodVault.rbxmx      (God Cataclysm vault)
  HUD.rbxmx     -> src/gui/HUD.rbxmx           (trimmed to the vault buttons + Cash counter)
  Style_1.rbxmx -> src/assets/UI/RarityTitle.rbxmx  (odds-list row template, a live snapshot of the screen)
                   src/assets/UI/RarityGradients.rbxmx (one UIGradient per rarity)

What it changes:
  * Renames Style/Zone-specific names to shared ones so one controller drives both screens
    (PlrStyle/PlrZone -> KitName, LimitedStyles/LimitedZones -> Vault, ...).
  * Removes features Disaster Run doesn't use (Switcher, Spin Burst, gifting, zone colours).
  * Rewrites placeholder text.
  * Strips CollectionService tag references (the exports have no shared-string table for them)
    and per-instance unique ids, so Rojo can load the files cleanly.
"""
import copy
import os
import xml.etree.ElementTree as ET

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "references", "BasketballGame", "UI")
GUI_OUT = os.path.join(ROOT, "src", "gui")
ASSET_OUT = os.path.join(ROOT, "src", "assets", "UI")

ET.register_namespace("xmime", "http://www.w3.org/2005/05/xmlmime")
ET.register_namespace("xsi", "http://www.w3.org/2001/XMLSchema-instance")

STRIP_PROPS = {("SharedString", "Tags"), ("UniqueId", "UniqueId"), ("UniqueId", "HistoryId")}


# ---------------------------------------------------------------- helpers
def props(item):
    return item.find("Properties")


def prop(item, name):
    for p in props(item):
        if p.get("name") == name:
            return p
    return None


def name_of(item):
    return prop(item, "Name").text


def set_name(item, value):
    prop(item, "Name").text = value


def set_text(item, value):
    p = prop(item, "Text")
    assert p is not None, f"{name_of(item)} has no Text"
    p.text = value


def set_bool(item, name, value):
    p = prop(item, name)
    assert p is not None, f"{name_of(item)} has no {name}"
    p.text = "true" if value else "false"


def children(item):
    return [c for c in item if c.tag == "Item"]


def child(item, name):
    for c in children(item):
        if name_of(c) == name:
            return c
    raise KeyError(f"{name_of(item)}.{name}")


def find_path(item, path):
    for part in path.split("."):
        item = child(item, part)
    return item


def remove(parent, name):
    parent.remove(child(parent, name))


def keep_only(parent, names):
    for c in children(parent):
        if name_of(c) not in names:
            parent.remove(c)


def clean(item):
    """Drop tag references and unique ids everywhere below item."""
    for it in item.iter("Item"):
        p = props(it)
        for q in list(p):
            if (q.tag, q.get("name")) in STRIP_PROPS:
                p.remove(q)


def load(fname):
    tree = ET.parse(os.path.join(SRC, fname))
    root = tree.getroot()
    return tree, root, root.find("Item")


def save_item(item, path):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    root = ET.Element("roblox", {
        "{http://www.w3.org/2001/XMLSchema-instance}noNamespaceSchemaLocation": "http://www.roblox.com/roblox.xsd",
        "version": "4",
    })
    for value in ("null", "nil"):
        ET.SubElement(root, "External").text = value
    root.append(item)
    clean(item)
    ET.indent(root, space="\t")
    ET.ElementTree(root).write(path, encoding="utf-8", xml_declaration=False)
    print("wrote", os.path.relpath(path, ROOT))


# ---------------------------------------------------------------- vaults
def build_vault(fname, gui_name, kind, title_name, out_name, words):
    _, _, gui = load(fname)
    set_name(gui, gui_name)
    set_bool(gui, "Enabled", False)
    set_bool(gui, "ResetOnSpawn", False)
    bg = child(gui, "BG")

    rename = {
        f"Plr{kind}": "KitName",
        f"Limited{kind}s": "Vault",
        f"Limited{kind}sButton": "VaultButton",
    }
    for old, new in rename.items():
        set_name(child(bg, old), new)

    for unused in ("SwitcherInput", "SwitcherConfirm", "SwitcherNote", "SwitcherCurrentUser",
                   "SpinBurst", "BurstCheckNotice", "ZoneColor"):
        try:
            remove(bg, unused)
        except KeyError:
            pass

    # Slots: shared label name, no gifting.
    for slot in children(child(bg, "Slots")):
        if not name_of(slot).startswith("Slot"):
            continue
        set_name(child(slot, f"{kind}Name"), "KitName")
        set_text(child(slot, "KitName"), "Empty")
        try:
            remove(slot, "Gift")
        except KeyError:
            pass

    for panel in ("BuySpinsUI", "BuyLuckySpinsUI"):
        for button in children(child(bg, panel)):
            if button.get("class") == "TextButton":
                try:
                    remove(button, "Gift")
                except KeyError:
                    pass

    # The kit title shouldn't carry a leftover gradient from the snapshot.
    title = child(bg, "KitName")
    for c in children(title):
        if c.get("class") == "UIGradient":
            title.remove(c)

    set_text(title, words["title"])
    set_text(child(bg, "Desc"), words["desc"])
    set_text(find_path(bg, "Spin.Left"), "0 Spins")
    set_text(find_path(bg, "LuckySpin.Left"), "0 Spins")
    set_text(find_path(bg, "CurrencyPitty.BG.Currency"), "$0")
    set_text(find_path(bg, "CurrencyPitty.Pity"), "Pity: 0/50")
    set_text(find_path(bg, "CurrencyPitty.LuckyPity"), "Lucky Pity: 0/75")
    set_text(find_path(bg, "Confirm.ConfirmationPrompt_Background.NoText"),
             f"Are you sure you want to spin your {words['noun']} away? This action can NOT be undone.")
    set_text(find_path(bg, "Vault.MainFrame.TitleText"), f"{words['vault']} VAULT")
    set_text(find_path(bg, "VaultButton.TextLabel"), "VAULT")
    for folder in children(child(bg, "Rarities")):
        set_text(child(folder, "0 OddsText"), f"Click a {words['noun']} to increase the odds of you getting it!")

    save_item(gui, os.path.join(GUI_OUT, out_name))


# ---------------------------------------------------------------- HUD
def build_hud():
    _, _, gui = load("HUD.rbxmx")
    set_bool(gui, "ResetOnSpawn", False)
    keep_only(gui, {"Buttons", "Top"})

    buttons = child(gui, "Buttons")
    keep_only(buttons, {"UIListLayout", "UIAspectRatioConstraint", "Zone", "Style"})
    set_name(child(buttons, "Zone"), "GodVault")
    set_name(child(buttons, "Style"), "RunnerVault")
    set_text(find_path(buttons, "GodVault.TextLabel"), "GOD KITS")
    set_text(find_path(buttons, "RunnerVault.TextLabel"), "RUNNER KITS")
    set_bool(find_path(buttons, "GodVault.Alert"), "Visible", False)
    set_bool(find_path(buttons, "RunnerVault.Alert"), "Visible", False)

    top = child(gui, "Top")
    keep_only(top, {"UIListLayout", "Currency"})
    currency = child(top, "Currency")
    keep_only(currency, {"Bg", "Icon", "Amount", "UIAspectRatioConstraint", "UIScale"})
    set_text(child(currency, "Amount"), "$0")

    save_item(gui, os.path.join(GUI_OUT, "HUD.rbxmx"))


# ---------------------------------------------------------------- templates
RARITY_SOURCES = {  # Disaster Run rarity -> rarity row in the snapshot whose gradient it reuses
    "Rare": "Rare",
    "Epic": "Epic",
    "Legendary": "Legendary",
    "Mythical": "Mythic",
    "Secret": "Miracle",
}
COMMON_COLOR = "0 0.92 0.92 0.92 0 1 0.62 0.62 0.62 0 "


def build_templates():
    _, _, gui = load("Style_1.rbxmx")
    normal = find_path(gui, "BG.Rarities.NormalRarities")

    # Row template: a rarity title button without its baked-in gradients.
    row = copy.deepcopy(child(normal, "Rare"))
    set_name(row, "RarityTitle")
    for c in children(row):
        if c.get("class") == "UIGradient":
            row.remove(c)
    label = child(row, "TextLabel")
    for c in children(label):
        if c.get("class") == "UIGradient":
            label.remove(c)
    set_text(label, "Rarity")
    set_text(child(row, "Percentage"), "(0%)")
    set_bool(child(row, "TimeLeft"), "Visible", False)
    save_item(row, os.path.join(ASSET_OUT, "RarityTitle.rbxmx"))

    # Gradients: the unmodified gradient lives on each row's TextLabel.
    folder = ET.Element("Item", {"class": "Folder", "referent": "RarityGradientsFolder"})
    fp = ET.SubElement(folder, "Properties")
    ET.SubElement(fp, "string", {"name": "Name"}).text = "RarityGradients"
    made = {}
    for rarity, source in RARITY_SOURCES.items():
        src_label = child(child(normal, source), "TextLabel")
        grad = next(c for c in children(src_label) if c.get("class") == "UIGradient")
        grad = copy.deepcopy(grad)
        set_name(grad, rarity)
        grad.set("referent", f"RarityGradient_{rarity}")
        folder.append(grad)
        made[rarity] = grad
    common = copy.deepcopy(made["Rare"])
    set_name(common, "Common")
    common.set("referent", "RarityGradient_Common")
    prop(common, "Color").text = COMMON_COLOR
    folder.insert(1, common)
    save_item(folder, os.path.join(ASSET_OUT, "RarityGradients.rbxmx"))


if __name__ == "__main__":
    build_vault("Style.rbxmx", "RunnerVault", "Style", "PlrStyle", "RunnerVault.rbxmx",
                {"title": "QUICK FEET", "desc": "", "noun": "kit", "vault": "RUNNER"})
    build_vault("Zone.rbxmx", "GodVault", "Zone", "PlrZone", "GodVault.rbxmx",
                {"title": "ROCKFALL", "desc": "", "noun": "kit", "vault": "GOD"})
    build_hud()
    build_templates()
