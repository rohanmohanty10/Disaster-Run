  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
local u1 = Random.new();

local function Lerp(p2, p3, p4) -- Line: 11
    return p2 + (p3 - p2) * p4;
end;

return function(p5, p6) -- Line: 17
    -- upvalues: AssetHandler (copy), u1 (copy), ParticleHandler (copy), CollectionService (copy)
    local u7 = game.Players:GetPlayerFromCharacter(p5):FindFirstChild("Data") or p5:FindFirstChild("Data");

    if not u7 then
        return;
    end;

    local u8 = p6 or {};
    local u9 = u8.RootPart or p5:FindFirstChild("HumanoidRootPart");

    if not u9 then
        return;
    end;

    local u10 = AssetHandler.GetAbilityData(p5);
    local v11 = AssetHandler.GetAsset("Models/BarrageArms", u10);
    local v12 = v11:FindFirstChild("Stand Right Arm");
    local v13 = v11:FindFirstChild("Stand Left Arm");
    local Inner = p5.Halo.Inner;
    local u14 = {
        Right = v12,
        Left = v13
    };
    local u15 = {
        Right = {},
        Left = {}
    };

    local function Create(p16) -- Line: 51
        -- upvalues: u14 (copy), Inner (copy), u15 (copy)
        local v17 = u14[p16]:Clone();
        v17:PivotTo(CFrame.new(0, 100000, 0));
        v17.Color = Inner.Color;
        v17.Parent = workspace;
        local v18 = {
            Active = false,
            Model = v17
        };
        table.insert(u15[p16], v18);

        return v18;
    end;

    local function Get(p19) -- Line: 64
        -- upvalues: u15 (copy)
        for _, v in pairs(u15[p19]) do
            if not v.Active then
                return v;
            end;
        end;
    end;

    local function Retrieve(p20) -- Line: 72
        -- upvalues: u15 (copy), Create (copy)
        for _, v in pairs(u15[p20]) do
            if not v.Active then
                break;
            end;
        end;

        return v or Create(p20);
    end;

    local function BarrageEffect() -- Line: 90
        -- upvalues: u1 (ref), u15 (copy), Create (copy), u10 (copy), ParticleHandler (ref), u7 (copy), u9 (copy), u8 (copy)
        local v21 = u1:NextInteger(1, 2);
        local v22 = v21 == 1 and "Left" or "Right";

        for _, v in pairs(u15[v22]) do
            if not v.Active then
                break;
            end;
        end;

        local v23 = v or Create(v22);
        local Model = v23.Model;
        v23.Active = true;
        Model.Transparency = 0.15;

        for _, descendant in pairs(Model:GetDescendants()) do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                descendant.Transparency = 0.15;
            end;
        end;

        local v24 = ParticleHandler.GetSkinInfo(not u10 and "" or u10.SkinName);

        if v24 and v24.Metadata then
            if v24.Metadata.HueShift then
                ParticleHandler.HueShiftParticles(Model, v24.Metadata.HueShift);
            end;

            if v24.Metadata.HSVShift then
                ParticleHandler.HSVShiftParticles(Model, v24.Metadata.HSVShift);
            end;
        end;

        local v25 = 0;

        if u7 and u7.Skin:GetAttribute("UnusualHueId") then
            v25 = v25 + u7.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        if v25 > 0 then
            ParticleHandler.HSVShiftParticles(Model, {
                HueShift = v25
            });
        end;

        ParticleHandler.EmitFromAttribute(Model);
        local v26 = u1:NextInteger(0.25, 2) * (v21 == 1 and 1 or -1);
        local v27 = u1:NextInteger(-1, 1.5);
        local v28 = u1:NextInteger(-0.25, 0.25);
        local v29 = u9.CFrame * (u8.Offset or CFrame.identity);
        local v30 = CFrame.new(v26, v27, v28);
        local Angles = CFrame.Angles;
        local v31 = u1:NextNumber(-15, 15);
        local v32 = math.rad(v31);
        local v33 = u1:NextNumber(-10, 10);
        local v34 = v29 * (v30 * Angles(v32, math.rad(v33), 0));
        local v35 = v34 * CFrame.new(0, 0, u1:NextNumber(6.25, 7.25) * -1);
        local v36 = os.clock();
        local v37 = v34 * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);
        local v38 = v35 * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);

        while os.clock() - v36 <= 0.15 do
            if os.clock() - v36 >= 0.05 then
                local v39 = os.clock() - v36;
                local v40 = math.abs(v39) / 0.09999999999999999;
                local v41 = 0 + 1 * math.clamp(v40, 0, 1);
                Model.Transparency = v41;

                for _, descendant in pairs(Model:GetDescendants()) do
                    if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                        descendant.Transparency = v41;
                    end;
                end;
            end;

            local v42 = os.clock() - v36;
            local v43 = math.abs(v42) / 0.15;
            Model:PivotTo(v37:Lerp(v38, (math.clamp(v43, 0, 1))));
            task.wait();
        end;

        v23.Active = false;
    end;

    local v44 = 0;

    local function Clear(p45) -- Line: 80
        -- upvalues: u15 (copy)
        for _, v in pairs(u15[p45]) do
            if v.Model then
                v.Model:Destroy();
                v.Model = nil;
            end;
        end;
    end;

    while p5 and (p5:IsDescendantOf(workspace) and CollectionService:HasTag(p5, "Barraging")) do
        if os.clock() - v44 >= 0.05 then
            v44 = os.clock();

            for _ = 1, 6 do
                task.spawn(BarrageEffect);
            end;
        end;

        task.wait();
    end;

    task.wait(1);
    Clear("Left");
    Clear("Right");
end;