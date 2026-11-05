  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local u1 = {};
local TableUtil = require(Core.ReplicatedLibraries.Utility.TableUtil);
local TweenModule = require(Core.ReplicatedLibraries.Classes.TweenModule);
local TweenService = game:GetService("TweenService");

function u1.GetTween(...) -- Line: 10
    -- upvalues: Core (copy), TweenModule (copy), TweenService (copy)
    if Core.Context == "Server" then
        return TweenModule:GetTweenObject(...);
    end;

    return TweenService:Create(...);
end;

function u1.ResolveTable(p2, p3, p4) -- Line: 18
    -- upvalues: Core (copy)
    local v5 = typeof(p2) == "Instance" and p2:IsA("ModuleScript") and require(p2) or typeof(p2) == "string" and Core.Require(p2, {
        HomeRoot = p3
    });

    if v5 then
        p2 = v5;
    elseif typeof(p2) ~= "table" then
        p2 = false;
    end;

    return p2 or nil;
end;

function u1.GetDataFromTable(p6, p7, p8) -- Line: 27
    -- upvalues: u1 (copy), TableUtil (copy)
    local v9 = p7 or {};

    for _, v in pairs(p6) do
        local v10 = u1.ResolveTable(v, p8);

        if v10 ~= nil then
            v9 = TableUtil.Reconcile(v9, v10);
        end;
    end;

    return v9;
end;

function u1.GetAngleBetween(p11, p12) -- Line: 38
    local v13 = p11.Unit:Dot(p12.Unit);
    local v14 = math.clamp(v13, -1, 1);

    return math.acos(v14);
end;

function u1.ReflectNormal(p15, p16) -- Line: 42
    return p16 - 2 * p16:Dot(p15) * p15;
end;

function u1.GetDashDirection(p17) -- Line: 46
    local v18 = math.atan2(p17.X, -p17.Z);
    local v19 = math.deg(v18) - 0.5;
    local v20 = math.ceil(v19);

    return v20 > 55 and v20 < 125 and "Right" or (v20 < -55 and v20 > -125 and "Left" or ((v20 <= -125 or v20 >= 125) and "Back" or "Forward"));
end;

function u1.IsMouseLocked() -- Line: 62
    return UserSettings().GameSettings.RotationType == Enum.RotationType.CameraRelative;
end;

function u1.WrapServiceMethods(u21) -- Line: 67
    for i, v in pairs(u21) do
        if typeof(v) == "function" then
            u21[i] = function(p22, ...) -- Line: 70
                -- upvalues: u21 (copy), v (copy)
                if p22 == u21 or typeof(p22) == "table" and p22.Name == u21.Name then
                    return v(...);
                end;

                return v(p22, ...);
            end;
        end;
    end;
end;

function u1.SetTransparency(p23) -- Line: 80
    -- upvalues: u1 (copy)
    local v24 = p23 or {};
    local Object = v24.Object;
    local v25 = v24.Path or "";
    local v26 = v24.Transparency or 0;
    local TweenInfo = v24.TweenInfo;
    local v27 = v24.Deep or false;
    local v28 = v24.Exclude or nil;

    if Object:IsA("BasePart") or (Object:IsA("Decal") or Object:IsA("Texture")) then
        local v29 = Object:GetAttribute("OriginalTransparency");

        if not v29 then
            v29 = Object.Transparency;
            Object:SetAttribute("OriginalTransparency", v29);
        end;

        local v30 = math.lerp(v29, 1, v26);

        if TweenInfo == nil or TweenInfo and TweenInfo.Time <= 0 then
            Object.Transparency = v30;
        else
            u1.GetTween(Object, TweenInfo, {
                Transparency = v30
            }):Play();
        end;
    end;

    if v27 == true then
        for _, child in pairs(Object:GetChildren()) do
            local v31;

            if v25 == "" then
                v31 = `{child.Name}`;
            else
                v31 = `{v25}/{child.Name}`;
            end;

            if not (v28 and v28[v31]) then
                u1.SetTransparency({
                    Deep = true,
                    Path = v31,
                    Object = child,
                    Transparency = v26,
                    TweenInfo = TweenInfo
                });
            end;
        end;
    end;
end;

function u1.ReconcileData(p32, p33) -- Line: 131
    -- upvalues: Core (copy), u1 (copy), TableUtil (copy)
    local v34 = p33 or {};

    if p32.From ~= nil then
        local v35 = {};

        for i, v in pairs(p32.From) do
            local v36 = v["@All"];
            local v37 = v["@Priority"] or 0;
            local v38 = v["@Context"];
            local v39 = nil;

            if v38 == nil or Core.Context == v38 then
                if v34.Transformer then
                    v39 = v34.Transformer(p32, v39, i);
                end;

                if v39 == nil then
                    local v40 = Core.Get({
                        IsA = "ModuleScript",
                        Path = i
                    }, v34.Directory);

                    if v40 then
                        v39 = require(v40);
                    end;
                end;

                if v39 ~= nil then
                    if v39.From then
                        v39 = u1.ReconcileData(table.clone(v39), v34);
                    end;

                    table.insert(v35, {
                        SourceData = v39,
                        SourceString = i,
                        SourceParameters = v,
                        Default = v36,
                        Priority = v37
                    });
                end;
            end;
        end;

        table.sort(v35, function(p41, p42) -- Line: 178
            return p41.Priority < p42.Priority;
        end);

        for _, v in pairs(v35) do
            local SourceData = v.SourceData;
            local _ = v.SourceString;
            local SourceParameters = v.SourceParameters;
            local Default = v.Default;

            for i, v2 in pairs(SourceData) do
                if i ~= "From" and (Default == true and SourceParameters[i] ~= false) then
                    if typeof(p32[i]) == "table" and typeof(v2) == "table" then
                        p32[i] = TableUtil.Reconcile(p32[i], v2);
                    elseif p32[i] == nil then
                        if typeof(v2) == "table" then
                            p32[i] = TableUtil.Copy(v2, true);
                        else
                            p32[i] = v2;
                        end;
                    end;
                end;
            end;

            for i, v2 in pairs(SourceParameters) do
                if i ~= "From" then
                    local v43 = SourceData[i];

                    if v43 ~= nil and (Default ~= true and v2 == true) then
                        if typeof(p32[i]) == "table" and typeof(v43) == "table" then
                            p32[i] = TableUtil.Reconcile(p32[i], v43);
                        elseif p32[i] == nil then
                            if typeof(v43) == "table" then
                                p32[i] = TableUtil.Copy(v43, true);
                            else
                                p32[i] = v43;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return p32;
end;

function u1.CombineValues(p44) -- Line: 230
end;

function u1.CombineMultipliers(p45) -- Line: 234
    local v46 = 0;

    for _, v in pairs(p45) do
        v46 = v46 + v;
    end;

    local v47 = 1 - (#p45 - v46);

    return v47 == 1 and 1 or v47;
end;

return u1;