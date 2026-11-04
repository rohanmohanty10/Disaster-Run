 
 

local u1 = {};
u1.__index = u1;
local script_Enums = require(script.Enums);
local script_State = require(script.State);
local Shared = script.Parent.Shared;
local React = require(Shared.React);
local ReactRoblox = require(Shared.ReactRoblox);
require(Shared.Signal);
local MainWindow = require(script.Components.MainWindow);

local function App(p2: table) -- Line: 59
    -- upvalues: React (copy), script_State (copy), MainWindow (copy)
    local createElement = React.createElement;
    local Driver = script_State.Driver;
    local v3 = {
        Ports = p2.Ports
    };
    local v4 = {};
    local v5 = p2.Enabled and React.createElement(MainWindow);
    v4.RelicsPlayer = v5;

    return createElement(Driver, v3, v4);
end;

function u1.new(p6: userdata) -- Line: 67
    -- upvalues: script_State (copy), ReactRoblox (copy), u1 (copy)
    local v7 = script_State.CreatePorts();
    local v8 = {
        _enabled = false,
        _root = ReactRoblox.createRoot(p6, {
            hydrate = true
        }),
        _internal = v7,
        SongChanged = v7.SongChanged,
        QueueChanged = v7.QueueChanged,
        VolumeChanged = v7.VolumeChanged,
        PlayingChanged = v7.PlayingChanged,
        WindowTabChanged = v7.WindowTabChanged,
        HasBoomboxChanged = v7.HasBoomboxChanged,
        WindowStateChanged = v7.WindowStateChanged
    };

    return setmetatable(v8, u1);
end;

function u1.SetEnabled(p9: any, p10: boolean) -- Line: 93
    -- upvalues: React (copy), App (copy)
    if p9._enabled == p10 then
        return;
    end;

    local v11 = React.createElement(App, {
        Ports = p9._internal,
        Enabled = p10
    });
    p9._root:render(v11);
    p9._enabled = p10;
end;

function u1.SetVolume(p12: any, p13: number) -- Line: 109
    local math_clamp_ret = math.clamp(p13, 0, 1);
    p12._internal.SetVolume:Fire(math_clamp_ret);
end;

function u1.SetWindowTab(p14, p15) -- Line: 117
    -- upvalues: script_Enums (copy)
    local v16 = script_Enums.WindowTab[p15];

    if not v16 then
        return false;
    end;

    p14._internal.SetWindowTab:Fire(v16);

    return true;
end;

function u1.SetWindowState(p17, p18) -- Line: 132
    -- upvalues: script_Enums (copy)
    local v19 = script_Enums.WindowState[p18];

    if not v19 then
        return false;
    end;

    p17._internal.SetWindowState:Fire(v19);

    return true;
end;

function u1.SetVolumeMod(p20: any, p21: any, p22: number?) -- Line: 147
    p20._internal.SetVolumeMod:Fire(p21, p22);
end;

function u1.SetPlaying(p23: any, p24: boolean) -- Line: 153
    p23._internal.SetPlaying:Fire(p24);
end;

function u1.SetSong(p25: any, p26: string) -- Line: 159
    p25._internal.SetSong:Fire(p26);
end;

function u1.SetQueue(p27: any, p28: table) -- Line: 165
    p27._internal.SetQueue:Fire(p28);
end;

function u1.SetLooping(p29: any, p30: boolean) -- Line: 171
    p29._internal.SetLooped:Fire(p30);
end;

function u1.UserHasBoombox(p31) -- Line: 176
    return p31._internal.HasBoombox or false;
end;

function u1.GetWindowTab(p32) -- Line: 181
    -- upvalues: script_Enums (copy)
    local WindowTab = p32._internal.WindowTab;

    return not WindowTab and "Play" or script_Enums.GetName(script_Enums.WindowTab, WindowTab);
end;

function u1.GetWindowState(p33) -- Line: 192
    -- upvalues: script_Enums (copy)
    local WindowState = p33._internal.WindowState;

    return not WindowState and "Hidden" or script_Enums.GetName(script_Enums.WindowState, WindowState);
end;

function u1.GetSong(p34) -- Line: 203
    return p34._internal.Song;
end;

function u1.GetVolume(p35) -- Line: 208
    return p35._internal.Volume or 0;
end;

function u1.IsLooping(p36) -- Line: 213
    return p36._internal.Looped or false;
end;

function u1.IsPlaying(p37) -- Line: 218
    return p37._internal.Playing or false;
end;

function u1.GetQueue(p38) -- Line: 223
    return p38._internal.Queue or {};
end;

return u1;