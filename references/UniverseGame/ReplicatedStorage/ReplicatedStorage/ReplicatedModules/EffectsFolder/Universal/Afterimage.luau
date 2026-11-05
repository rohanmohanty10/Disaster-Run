  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local _ = ReplicatedStorage["Client Assets"];
local _ = Players.LocalPlayer;

return function(p1) -- Line: 17
    -- upvalues: GenericModule (copy), TweenService (copy)
    local u2 = p1 or {};
    local Whitelist = u2.Whitelist;
    local u3 = u2.Lifetime or 0.5;
    local Origin = u2.Origin;
    local Transparency = u2.Transparency;
    local u4 = { "Model", "LocalScript", "Script", "Sound", "HumanoidRootPart", "Folder", "BillboardGui", "SurfaceGui", "ScreenGui", "BallSocketConstraint", "NoCollisionConstraint" };

    if u2.Blacklist then
        for _, v in pairs(u2.Blacklist) do
            table.insert(u4, v);
        end;
    end;

    if u2.RemoveDefaultBlacklist then
        for _, v in u2.RemoveDefaultBlacklist do
            local v5 = table.find(u4, v);

            if v5 then
                table.remove(u4, v5);
            end;
        end;
    end;

    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;
    task.delay(u3, Model.Destroy, Model);
    os.clock();

    local function BasePart(p6, p7) -- Line: 49
        -- upvalues: Transparency (copy), u2 (ref), GenericModule (ref), TweenService (ref), u3 (copy)
        if not p6:IsA("BasePart") then
            return;
        end;

        p6.CanCollide = false;
        p6.CanQuery = false;
        p6.Anchored = true;
        p6.CastShadow = false;
        p6.CollisionGroup = "Ghosted";

        if p7 then
            p6.CFrame = p7.CFrame;
        end;

        local v8 = p6:GetAttribute("OverrideTransparency") or p6:GetAttribute("OriginalTransparency");

        if v8 then
            p6.Transparency = v8;
        end;

        if Transparency then
            p6.Transparency = u2.BypassTransparency and Transparency or GenericModule.Lerp(p6.Transparency, 1, Transparency);
        end;

        local v9 = p6:FindFirstChildOfClass("Decal");

        if v9 then
            v9.Transparency = p6.Transparency;

            if u2.Tween ~= false then
                TweenService:Create(v9, TweenInfo.new(u3, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
            end;
        end;

        if u2.Tween ~= false then
            TweenService:Create(p6, TweenInfo.new(u3, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
        end;
    end;

    local function ImportObject(p10) -- Line: 84
        -- upvalues: u4 (copy), BasePart (copy), Model (copy)
        if not p10.Archivable then
            return;
        end;

        local v11 = p10:Clone();

        for _, descendant in pairs(v11:GetDescendants()) do
            if table.find(u4, descendant.ClassName) or table.find(u4, descendant.Name) then
                descendant:Destroy();
            end;
        end;

        if v11:IsA("Humanoid") then
            v11.DisplayDistanceType = "None";
            v11.HealthDisplayType = "AlwaysOff";
            v11.BreakJointsOnDeath = false;
            v11.EvaluateStateMachine = false;
            v11.RequiresNeck = false;
            v11.AutomaticScalingEnabled = false;
        end;

        for _, descendant in pairs(v11:GetDescendants()) do
            if descendant:IsA("Motor6D") or (descendant:IsA("Weld") or (descendant:IsA("ManualWeld") or descendant:IsA("WeldConstraint"))) then
                descendant:Destroy();
            end;
        end;

        if v11:IsA("Accessory") then
            v11 = v11:FindFirstChild("handle") or v11:FindFirstChild("Handle");
            p10 = p10:FindFirstChild("handle") or p10:FindFirstChild("Handle");
        end;

        for _, descendant in v11:GetDescendants() do
            BasePart(descendant);
        end;

        BasePart(v11, p10);
        v11.Parent = Model;

        if v11.Name == "HumanoidRootPart" then
            Model.PrimaryPart = v11;
        end;
    end;

    if Whitelist then
        for i = 1, #Whitelist do
            for _, child in pairs(Whitelist[i]:GetChildren()) do
                if child and (child:IsDescendantOf(game) and not (table.find(u4, child.ClassName) or table.find(u4, child.Name))) then
                    ImportObject(child);
                end;
            end;
        end;
    end;

    if Origin then
        Model:PivotTo(Origin);
    end;

    return Model;
end;