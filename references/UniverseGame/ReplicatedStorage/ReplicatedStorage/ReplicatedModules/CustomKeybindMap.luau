  

 

local v1 = {
    [Enum.KeyCode.Unknown] = 1,
    [Enum.KeyCode.Backspace] = 2,
    [Enum.KeyCode.Tab] = 3,
    [Enum.KeyCode.Clear] = 4,
    [Enum.KeyCode.Return] = 5,
    [Enum.KeyCode.Pause] = 6,
    [Enum.KeyCode.Escape] = 7,
    [Enum.KeyCode.Space] = 8,
    [Enum.KeyCode.QuotedDouble] = 9,
    [Enum.KeyCode.Hash] = 10,
    [Enum.KeyCode.Dollar] = 11,
    [Enum.KeyCode.Percent] = 12,
    [Enum.KeyCode.Ampersand] = 13,
    [Enum.KeyCode.Quote] = 14,
    [Enum.KeyCode.LeftParenthesis] = 15,
    [Enum.KeyCode.RightParenthesis] = 16,
    [Enum.KeyCode.Asterisk] = 17,
    [Enum.KeyCode.Plus] = 18,
    [Enum.KeyCode.Comma] = 19,
    [Enum.KeyCode.Minus] = 20,
    [Enum.KeyCode.Period] = 21,
    [Enum.KeyCode.Slash] = 22,
    [Enum.KeyCode.Zero] = 23,
    [Enum.KeyCode.One] = 24,
    [Enum.KeyCode.Two] = 25,
    [Enum.KeyCode.Three] = 26,
    [Enum.KeyCode.Four] = 27,
    [Enum.KeyCode.Five] = 28,
    [Enum.KeyCode.Six] = 29,
    [Enum.KeyCode.Seven] = 30,
    [Enum.KeyCode.Eight] = 31,
    [Enum.KeyCode.Nine] = 32,
    [Enum.KeyCode.Colon] = 33,
    [Enum.KeyCode.Semicolon] = 34,
    [Enum.KeyCode.LessThan] = 35,
    [Enum.KeyCode.Equals] = 36,
    [Enum.KeyCode.GreaterThan] = 37,
    [Enum.KeyCode.Question] = 38,
    [Enum.KeyCode.At] = 39,
    [Enum.KeyCode.LeftBracket] = 40,
    [Enum.KeyCode.BackSlash] = 41,
    [Enum.KeyCode.RightBracket] = 42,
    [Enum.KeyCode.Caret] = 43,
    [Enum.KeyCode.Underscore] = 44,
    [Enum.KeyCode.Backquote] = 45,
    [Enum.KeyCode.A] = 46,
    [Enum.KeyCode.B] = 47,
    [Enum.KeyCode.C] = 48,
    [Enum.KeyCode.D] = 49,
    [Enum.KeyCode.E] = 50,
    [Enum.KeyCode.F] = 51,
    [Enum.KeyCode.G] = 52,
    [Enum.KeyCode.H] = 53,
    [Enum.KeyCode.I] = 54,
    [Enum.KeyCode.J] = 55,
    [Enum.KeyCode.K] = 56,
    [Enum.KeyCode.L] = 57,
    [Enum.KeyCode.M] = 58,
    [Enum.KeyCode.N] = 59,
    [Enum.KeyCode.O] = 60,
    [Enum.KeyCode.P] = 61,
    [Enum.KeyCode.Q] = 62,
    [Enum.KeyCode.R] = 63,
    [Enum.KeyCode.S] = 64,
    [Enum.KeyCode.T] = 65,
    [Enum.KeyCode.U] = 66,
    [Enum.KeyCode.V] = 67,
    [Enum.KeyCode.W] = 68,
    [Enum.KeyCode.X] = 69,
    [Enum.KeyCode.Y] = 70,
    [Enum.KeyCode.Z] = 71,
    [Enum.KeyCode.LeftCurly] = 72,
    [Enum.KeyCode.Pipe] = 73,
    [Enum.KeyCode.RightCurly] = 74,
    [Enum.KeyCode.Tilde] = 75,
    [Enum.KeyCode.Delete] = 76,
    [Enum.KeyCode.KeypadZero] = 77,
    [Enum.KeyCode.KeypadOne] = 78,
    [Enum.KeyCode.KeypadTwo] = 79,
    [Enum.KeyCode.KeypadThree] = 80,
    [Enum.KeyCode.KeypadFour] = 81,
    [Enum.KeyCode.KeypadFive] = 82,
    [Enum.KeyCode.KeypadSix] = 83,
    [Enum.KeyCode.KeypadSeven] = 84,
    [Enum.KeyCode.KeypadEight] = 85,
    [Enum.KeyCode.KeypadNine] = 86,
    [Enum.KeyCode.KeypadPeriod] = 87,
    [Enum.KeyCode.KeypadDivide] = 88,
    [Enum.KeyCode.KeypadMultiply] = 89,
    [Enum.KeyCode.KeypadMinus] = 90,
    [Enum.KeyCode.KeypadPlus] = 91,
    [Enum.KeyCode.KeypadEnter] = 92,
    [Enum.KeyCode.KeypadEquals] = 93,
    [Enum.KeyCode.Up] = 94,
    [Enum.KeyCode.Down] = 95,
    [Enum.KeyCode.Right] = 96,
    [Enum.KeyCode.Left] = 97,
    [Enum.KeyCode.Insert] = 98,
    [Enum.KeyCode.Home] = 99,
    [Enum.KeyCode.End] = 100,
    [Enum.KeyCode.PageUp] = 101,
    [Enum.KeyCode.PageDown] = 102,
    [Enum.KeyCode.F1] = 103,
    [Enum.KeyCode.F2] = 104,
    [Enum.KeyCode.F3] = 105,
    [Enum.KeyCode.F4] = 106,
    [Enum.KeyCode.F5] = 107,
    [Enum.KeyCode.F6] = 108,
    [Enum.KeyCode.F7] = 109,
    [Enum.KeyCode.F8] = 110,
    [Enum.KeyCode.F9] = 111,
    [Enum.KeyCode.F10] = 112,
    [Enum.KeyCode.F11] = 113,
    [Enum.KeyCode.F12] = 114,
    [Enum.KeyCode.F13] = 115,
    [Enum.KeyCode.F14] = 116,
    [Enum.KeyCode.F15] = 117,
    [Enum.KeyCode.NumLock] = 118,
    [Enum.KeyCode.CapsLock] = 119,
    [Enum.KeyCode.ScrollLock] = 120,
    [Enum.KeyCode.RightShift] = 121,
    [Enum.KeyCode.LeftShift] = 122,
    [Enum.KeyCode.RightControl] = 123,
    [Enum.KeyCode.LeftControl] = 124,
    [Enum.KeyCode.RightAlt] = 125,
    [Enum.KeyCode.LeftAlt] = 126,
    [Enum.KeyCode.RightMeta] = 127,
    [Enum.KeyCode.LeftMeta] = 128,
    [Enum.KeyCode.LeftSuper] = 129,
    [Enum.KeyCode.RightSuper] = 130,
    [Enum.KeyCode.Mode] = 131,
    [Enum.KeyCode.Compose] = 132,
    [Enum.KeyCode.Help] = 133,
    [Enum.KeyCode.Print] = 134,
    [Enum.KeyCode.SysReq] = 135,
    [Enum.KeyCode.Break] = 136,
    [Enum.KeyCode.Menu] = 137,
    [Enum.KeyCode.Power] = 138,
    [Enum.KeyCode.Euro] = 139,
    [Enum.KeyCode.Undo] = 140,
    [Enum.KeyCode.ButtonX] = 141,
    [Enum.KeyCode.ButtonY] = 142,
    [Enum.KeyCode.ButtonA] = 143,
    [Enum.KeyCode.ButtonB] = 144,
    [Enum.KeyCode.ButtonR1] = 145,
    [Enum.KeyCode.ButtonL1] = 146,
    [Enum.KeyCode.ButtonR2] = 147,
    [Enum.KeyCode.ButtonL2] = 148,
    [Enum.KeyCode.ButtonR3] = 149,
    [Enum.KeyCode.ButtonL3] = 150,
    [Enum.KeyCode.ButtonStart] = 151,
    [Enum.KeyCode.ButtonSelect] = 152,
    [Enum.KeyCode.DPadLeft] = 153,
    [Enum.KeyCode.DPadRight] = 154,
    [Enum.KeyCode.DPadUp] = 155,
    [Enum.KeyCode.DPadDown] = 156,
    [Enum.KeyCode.Thumbstick1] = 157,
    [Enum.KeyCode.Thumbstick2] = 158,
    [Enum.KeyCode.MouseLeftButton] = 159,
    [Enum.KeyCode.MouseRightButton] = 160,
    [Enum.KeyCode.MouseMiddleButton] = 161,
    [Enum.KeyCode.MousePosition] = 162,
    [Enum.KeyCode.World0] = 163,
    [Enum.KeyCode.World1] = 164,
    [Enum.KeyCode.World2] = 165,
    [Enum.KeyCode.World3] = 166,
    [Enum.KeyCode.World4] = 167,
    [Enum.KeyCode.World5] = 168,
    [Enum.KeyCode.World6] = 169,
    [Enum.KeyCode.World7] = 170,
    [Enum.KeyCode.World8] = 171,
    [Enum.KeyCode.World9] = 172,
    [Enum.KeyCode.World10] = 173,
    [Enum.KeyCode.World11] = 174,
    [Enum.KeyCode.World12] = 175,
    [Enum.KeyCode.World13] = 176,
    [Enum.KeyCode.World14] = 177,
    [Enum.KeyCode.World15] = 178,
    [Enum.KeyCode.World16] = 179,
    [Enum.KeyCode.World17] = 180,
    [Enum.KeyCode.World18] = 181,
    [Enum.KeyCode.World19] = 182,
    [Enum.KeyCode.World20] = 183,
    [Enum.KeyCode.World21] = 184,
    [Enum.KeyCode.World22] = 185,
    [Enum.KeyCode.World23] = 186,
    [Enum.KeyCode.World24] = 187,
    [Enum.KeyCode.World25] = 188,
    [Enum.KeyCode.World26] = 189,
    [Enum.KeyCode.World27] = 190,
    [Enum.KeyCode.World28] = 191,
    [Enum.KeyCode.World29] = 192,
    [Enum.KeyCode.World30] = 193,
    [Enum.KeyCode.World31] = 194,
    [Enum.KeyCode.World32] = 195,
    [Enum.KeyCode.World33] = 196,
    [Enum.KeyCode.World34] = 197,
    [Enum.KeyCode.World35] = 198,
    [Enum.KeyCode.World36] = 199,
    [Enum.KeyCode.World37] = 200,
    [Enum.KeyCode.World38] = 201,
    [Enum.KeyCode.World39] = 202,
    [Enum.KeyCode.World40] = 203,
    [Enum.KeyCode.World41] = 204,
    [Enum.KeyCode.World42] = 205,
    [Enum.KeyCode.World43] = 206,
    [Enum.KeyCode.World44] = 207,
    [Enum.KeyCode.World45] = 208,
    [Enum.KeyCode.World46] = 209,
    [Enum.KeyCode.World47] = 210,
    [Enum.KeyCode.World48] = 211,
    [Enum.KeyCode.World49] = 212,
    [Enum.KeyCode.World50] = 213,
    [Enum.KeyCode.World51] = 214,
    [Enum.KeyCode.World52] = 215,
    [Enum.KeyCode.World53] = 216,
    [Enum.KeyCode.World54] = 217,
    [Enum.KeyCode.World55] = 218,
    [Enum.KeyCode.World56] = 219,
    [Enum.KeyCode.World57] = 220,
    [Enum.KeyCode.World58] = 221,
    [Enum.KeyCode.World59] = 222,
    [Enum.KeyCode.World60] = 223,
    [Enum.KeyCode.World61] = 224,
    [Enum.KeyCode.World62] = 225,
    [Enum.KeyCode.World63] = 226,
    [Enum.KeyCode.World64] = 227,
    [Enum.KeyCode.World65] = 228,
    [Enum.KeyCode.World66] = 229,
    [Enum.KeyCode.World67] = 230,
    [Enum.KeyCode.World68] = 231,
    [Enum.KeyCode.World69] = 232,
    [Enum.KeyCode.World70] = 233,
    [Enum.KeyCode.World71] = 234,
    [Enum.KeyCode.World72] = 235,
    [Enum.KeyCode.World73] = 236,
    [Enum.KeyCode.World74] = 237,
    [Enum.KeyCode.World75] = 238,
    [Enum.KeyCode.World76] = 239,
    [Enum.KeyCode.World77] = 240,
    [Enum.KeyCode.World78] = 241,
    [Enum.KeyCode.World79] = 242,
    [Enum.KeyCode.World80] = 243,
    [Enum.KeyCode.World81] = 244,
    [Enum.KeyCode.World82] = 245,
    [Enum.KeyCode.World83] = 246,
    [Enum.KeyCode.World84] = 247,
    [Enum.KeyCode.World85] = 248,
    [Enum.KeyCode.World86] = 249,
    [Enum.KeyCode.World87] = 250,
    [Enum.KeyCode.World88] = 251,
    [Enum.KeyCode.World89] = 252,
    [Enum.KeyCode.World90] = 253,
    [Enum.KeyCode.World91] = 254,
    [Enum.KeyCode.World92] = 255,
    [Enum.KeyCode.World93] = 256,
    [Enum.KeyCode.World94] = 257,
    [Enum.KeyCode.World95] = 258,
    [Enum.KeyCode.MouseBackButton] = 259,
    [Enum.KeyCode.MouseNoButton] = 260,
    [Enum.KeyCode.MouseX] = 261,
    [Enum.KeyCode.MouseY] = 262,
    [Enum.UserInputType.MouseButton1] = 263,
    [Enum.UserInputType.MouseButton2] = 264,
    [Enum.UserInputType.MouseButton3] = 265,
    [Enum.UserInputType.MouseWheel] = 266,
    [Enum.UserInputType.MouseMovement] = 267,
    [Enum.UserInputType.Touch] = 268,
    [Enum.UserInputType.Keyboard] = 269,
    [Enum.UserInputType.Focus] = 270,
    [Enum.UserInputType.Accelerometer] = 271,
    [Enum.UserInputType.Gyro] = 272,
    [Enum.UserInputType.Gamepad1] = 273,
    [Enum.UserInputType.Gamepad2] = 274,
    [Enum.UserInputType.Gamepad3] = 275,
    [Enum.UserInputType.Gamepad4] = 276,
    [Enum.UserInputType.Gamepad5] = 277,
    [Enum.UserInputType.Gamepad6] = 278,
    [Enum.UserInputType.Gamepad7] = 279,
    [Enum.UserInputType.Gamepad8] = 280,
    [Enum.UserInputType.TextInput] = 281,
    [Enum.UserInputType.InputMethod] = 282,
    [Enum.UserInputType.None] = 283
};
local v2 = 0;
local u3 = {
    KeybindsMap = {},
    KeybindsEnums = {},
    Keybinds = {},
    InversedKeybindsMap = {},
    InversedKeybindsEnums = {},
    InversedKeybinds = {}
};

for _ in v1 do
    v2 = v2 + 1;
end;

local v4 = v2 + 1;

for _, v in Enum.KeyCode:GetEnumItems() do
    if v1[v] == nil then
        v1[v] = v4;
        v4 = v4 + 1;
    end;
end;

for _, v in Enum.UserInputType:GetEnumItems() do
    if v1[v] == nil then
        v1[v] = v4;
        v4 = v4 + 1;
    end;
end;

for i, v in v1 do
    u3.Keybinds[v] = i.Name;
    u3.KeybindsEnums[v] = i;
end;

for i, v in u3.Keybinds do
    u3.KeybindsMap[v:upper()] = i;
end;

for i, v in pairs(u3.Keybinds) do
    u3.InversedKeybinds[v] = i;
end;

for i, v in pairs(u3.KeybindsEnums) do
    u3.InversedKeybindsEnums[v] = i;
end;

for i, v in pairs(u3.KeybindsMap) do
    u3.InversedKeybindsMap[v] = i;
end;

function u3.GetKeybindValue(p5) -- Line: 342
    -- upvalues: u3 (copy)
    return u3.KeybindsMap[p5:upper()];
end;

function u3.GetKeybindsMap() -- Line: 346
    -- upvalues: u3 (copy)
    return u3.KeybindsMap;
end;

function u3.GetKeybinds() -- Line: 350
    -- upvalues: u3 (copy)
    return u3.Keybinds;
end;

function u3.GetInversedKeybindsMap() -- Line: 354
    -- upvalues: u3 (copy)
    return u3.InversedKeybindsMap;
end;

function u3.GetInversedKeybinds() -- Line: 358
    -- upvalues: u3 (copy)
    return u3.InversedKeybinds;
end;

return u3;