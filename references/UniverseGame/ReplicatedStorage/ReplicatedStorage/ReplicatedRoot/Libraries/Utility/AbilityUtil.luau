  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local u1 = {
    Cache = {}
};
local TableUtil = require(Core.ReplicatedLibraries.Utility.TableUtil);
local CommonUtil = require(Core.ReplicatedLibraries.Utility.CommonUtil);
local AssetService = require(Core.ReplicatedServices.AssetService);

function u1.GetCachedAbility(p2) -- Line: 12
    -- upvalues: u1 (copy), Core (copy), TableUtil (copy), CommonUtil (copy), AssetService (copy)
    local v3 = p2 or {};
    local _ = v3.Character or v3.Player and v3.Player.Character;
    local _ = v3.Player or v3.Character ~= nil and game.Players:GetPlayerFromCharacter(v3.Character);
    local AbilityName = v3.AbilityName;
    local SkinName = v3.SkinName;
    local v4 = v3.AbilityPath or `Abilities/{AbilityName}`;
    local v5 = `{AbilityName}` .. (SkinName == nil and "" or (`:{SkinName}` or ""));
    local v6 = u1.Cache[v5];

    if v6 ~= nil then
        return v6;
    end;

    local v7 = {};
    u1.Cache[v5] = v7;
    local v8;

    if Core.Context == "Server" then
        v8 = Core.Require((`{v4}/ServerAbility`)) or nil;
    else
        v8 = nil;
    end;

    local v9 = Core.Require((`{v4}/ReplicatedAbility`)) or nil;
    local v10 = TableUtil.Reconcile(v8 or {}, v9 or {});

    if v10.Name == nil then
        v10.Name = AbilityName;
    end;

    if v10.From then
        for _, v in pairs(v10.From) do
            local v11 = u1.GetAbilityData({
                AbilityName = v
            });

            if v11 ~= nil then
                v10 = TableUtil.Reconcile(v10, v11);
            end;
        end;

        v10.From = nil;
    end;

    for _, v in pairs({ "Animations", "RigInfo", "Movesets", "Schema" }) do
        local v12 = v10[v];

        if v12 ~= nil and v12.From ~= nil then
            v10[v] = CommonUtil.GetDataFromTable(v12.From or {}, v12, v4);
            v10[v].From = nil;
        end;
    end;

    v7.Data = v10;
    v7.Directory = AssetService.CreateDirectory({
        HomeRoot = v4,
        Aliases = {
            Data = v10,
            Animations = v10.Animations,
            Rigs = Core.Get({
                Path = `{v4}/Assets/Rigs`
            }),
            Projectiles = Core.Get({
                Path = `{v4}/Assets/Projectiles`
            })
        }
    });
    v7.Directory:BindToExternalDirectory(Core.Directory);

    return v7;
end;

function u1.GetAbilityData(p13) -- Line: 88
    -- upvalues: u1 (copy)
    local v14 = u1.GetCachedAbility(p13);

    return v14 and v14.Data or nil;
end;

function u1.GetAbilityDirectory(p15) -- Line: 93
    -- upvalues: u1 (copy)
    local v16 = u1.GetCachedAbility(p15);

    return v16 and v16.Directory or nil;
end;

function u1.AddModules(p17, p18, p19) -- Line: 98
    -- upvalues: u1 (copy)
    local v20 = p18 or `~/{p17.Name}`;
    local v21 = p19 or {};

    for _, child in pairs(p17:GetChildren()) do
        if child:IsA("ModuleScript") then
            v21[child.Name] = {
                From = { (`{v20}/{child.Name}`) }
            };
        else
            u1.AddModules(child, `{v20}/{child.Name}`, v21);
        end;
    end;

    return v21;
end;

return u1;