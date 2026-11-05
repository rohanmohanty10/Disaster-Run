  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
local Signal = require(ReplicatedRoot.Libraries.Classes.Signal);
require(ReplicatedRoot.Libraries.Classes.Rig);
game:GetService("HttpService");
local SharedFunctionService = require(ReplicatedRoot.Services.SharedFunctionService);
local u1 = {
    ClassName = "Ability"
};
u1.__index = u1;
require(ReplicatedRoot.Libraries.Types.CommonTypes);

function u1.new(p2, p3) -- Line: 53
    -- upvalues: u1 (copy), Trove (copy), Signal (copy)
    local u4 = setmetatable({}, u1);
    u4.Character = p2;
    u4.Humanoid = p2.Humanoid;
    u4.RootPart = p2.HumanoidRootPart;
    u4.Player = game.Players:GetPlayerFromCharacter(p2);
    u4.Collector = Trove.new();
    u4.Data = p3;
    u4.Name = p3.Name or "Ability";
    u4.Directory = p3.Directory or {};
    u4.Skin = p3.Skin or "";
    u4.Active = true;
    u4.Activated = u4.Collector:Construct(Signal);
    u4.Deactivated = u4.Collector:Construct(Signal);
    u4.Initialized = u4.Collector:Construct(Signal);
    u4.State = {};
    u4.Moves = {};
    u4.Rigs = {};

    if u4.Data.Common ~= nil then
        for i, v in pairs(u4.Data.Common) do
            if string.sub(i, 1, 4) == "Init" then
                u4.Collector:Connect(u4.Initialized, function() -- Line: 82
                    -- upvalues: v (copy), u4 (copy)
                    v(u4);
                end);
            else
                u4[i] = v;
            end;
        end;
    end;

    return u4;
end;

function u1.Init(p5) -- Line: 95
    if p5._Initialized then
        return;
    end;

    p5._Initialized = true;
    p5.Initialized:Fire();

    if p5.Data.Common ~= nil then
        for i, v in pairs(p5.Data.Common) do
            if string.sub(i, 1, 5) == "Start" then
                v(p5);
            end;
        end;
    end;
end;

function u1.IsActive(p6) -- Line: 120
    return p6.Active;
end;

function u1.Activate(p7) -- Line: 124
    if p7.Active then
        return;
    end;

    p7.Active = true;
    p7.Activated:Fire();
end;

function u1.Deactivate(p8) -- Line: 133
    p8.Active = false;
    p8.Deactivated:Fire();
end;

function u1.CallFunction(p9, p10, ...) -- Line: 138
    -- upvalues: SharedFunctionService (copy), u1 (copy)
    local v11 = SharedFunctionService.GetFunction(p10, {
        Ability = p9
    });

    if v11 ~= nil then
        return SharedFunctionService.CallFunction(v11, {
            Character = p9.Character,
            Ability = u1
        }, ...);
    end;
end;

function u1.Destroy(p12) -- Line: 150
    if table.isfrozen(p12) then
        return;
    end;

    p12.Collector:Destroy();
    table.clear(p12);
    table.freeze(p12);
end;

function u1.AddMove(p13, p14) -- Line: 162
    if p13.Moves[p14.Name] then
        return;
    end;

    p14.Ability = p13;

    if p14.Directory.Roots == nil then
        p14.Directory.Roots = {};
    end;

    for _, v in pairs(p13.Directory and (p13.Directory.Roots or {}) or {}) do
        table.insert(p14.Directory.Roots, v);
    end;

    p13.Moves[p14.Name] = p14;

    if p13._Initialized and not p14._Initialized then
        p14:Init();
    end;
end;

return u1;