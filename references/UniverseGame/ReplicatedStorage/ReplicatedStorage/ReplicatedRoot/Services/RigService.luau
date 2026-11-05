  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;

if game:GetService("RunService"):IsServer() then
    local _ = game.ServerStorage.ServerRoot;
end;

local Core = require(ReplicatedRoot.Core);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local Rig = require(ReplicatedRoot.Libraries.Classes.Rig);
local u1 = {
    Name = "RigService"
};
require(ReplicatedRoot.Libraries.Types.CommonTypes);

function u1.CreateRig(p2, p3) -- Line: 22
    -- upvalues: Rig (copy)
    return Rig.new(p2, p3);
end;

function u1.GenerateRigs(u4, p5, ...) -- Line: 26
    -- upvalues: TableUtil (copy), Core (copy), u1 (copy)
    local v6 = p5 and table.clone(p5) or {};
    local Directory = v6.Directory;
    local Transformer = v6.Transformer;
    local v7 = v6.Rigs and (TableUtil.Copy(v6.Rigs, true) or {}) or {};
    local v8 = {
        Player = game.Players:GetPlayerFromCharacter(u4),
        Character = u4,
        Humanoid = u4:FindFirstChildWhichIsA("Humanoid"),
        RootPart = u4:FindFirstChild("HumanoidRootPart"),
        Directory = Directory,
        Rigs = v7
    };

    if Transformer ~= nil then
        Transformer(v8, ...);
    end;

    local u9 = {};

    local function Construct(p10, p11, p12) -- Line: 47
        -- upvalues: Core (ref), Directory (copy), TableUtil (ref), u1 (ref), u4 (copy), u9 (copy), Construct (copy)
        local From = p11.From;

        if From then
            From = Core.Require({
                Path = `Rigs/{From}`
            }, Directory);
        end;

        if From then
            p11 = TableUtil.Reconcile(p11, From);
        end;

        local v13 = nil;

        if typeof(p11.RigModel) == "Instance" then
            v13 = p11.RigModel;
        elseif typeof(p11.RigModel) == "string" then
            v13 = Core.Get({
                Debug = true,
                Path = p11.RigModel
            }, Directory);

            if v13 == nil then
                warn("Failed to get Rig Model", p11.RigModel);

                return;
            end;
        end;

        local v14 = u1.CreateRig(p11, {
            CloneRigModel = true,
            RigModel = v13,
            Parent = p12 or u4
        });
        u9[p10] = v14;

        if p11.Children then
            for i, v in pairs(p11.Children) do
                Construct(i, v, v14);
            end;
        end;
    end;

    for i, v in pairs(v7) do
        Construct(i, v);
    end;

    local PostRig = v6.PostRig;

    if PostRig ~= nil then
        PostRig(v8, ...);
    end;

    return u9;
end;

function u1._Init() -- Line: 97
    -- upvalues: Core (copy), u1 (copy)
    if Core.Context == "Client" then
        u1.AbilityCache = game.ReplicatedStorage:WaitForChild("AbilityCache");

        return;
    end;

    if Core.Context == "Server" then
        u1.AbilityCache = Instance.new("Folder");
        u1.AbilityCache.Name = "AbilityCache";
        u1.AbilityCache.Archivable = false;
        u1.AbilityCache.Parent = game.ReplicatedStorage;
    end;
end;

function u1._Start() -- Line: 108
    -- upvalues: Core (copy)
    Core.GetClientService("RigService");
    local _ = Core.Context == "Client";
end;

return u1;