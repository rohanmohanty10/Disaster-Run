  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local CollectionService = game:GetService("CollectionService");
game:GetService("TweenService");
local u1 = Random.new();

local function Lerp(p2, p3, p4) -- Line: 9
    return p2 + (p3 - p2) * p4;
end;

return function(u5, p6) -- Line: 13
    -- upvalues: PathShortcuts (copy), u1 (copy), CollectionService (copy)
    local v7 = (game.Players:GetPlayerFromCharacter(u5) or u5):FindFirstChild("Data") or u5:FindFirstChild("Data");

    if not v7 then
        return;
    end;

    local u8 = p6 or {};
    local v9 = u8.LimbType or "Arm";
    local u10 = u8.RootPart or u5:FindFirstChild("HumanoidRootPart");

    if not u10 then
        return;
    end;

    local v11 = u8.AbilityName or v7.Ability:GetAttribute("AbilityName");
    local v12 = u8.SkinName or v7.Skin:GetAttribute("SkinName");
    local v13 = PathShortcuts.ClientAssets:FindFirstChild(v11);

    if not v13 then
        return;
    end;

    local v14;

    if v12 then
        if v12 == "" then
            v14 = false;
        else
            v14 = v13:FindFirstChild(v12);
        end;
    else
        v14 = v12;
    end;

    local Stand = u5:FindFirstChild("Stand");
    local v15, v16;

    if Stand then
        v15 = Stand:FindFirstChild("Stand Right " .. v9);
        v16 = Stand:FindFirstChild("Stand Left " .. v9);
    else
        v15 = nil;
        v16 = nil;
    end;

    if not (v15 and v16) then
        local v17 = v14 and v14:FindFirstChild("BarrageArms") or (v13:FindFirstChild("BarrageArms") or (v14 or v13));

        if v12 and (v12 ~= "" and v17:FindFirstChild(v12)) then
            v17 = v17[v12];
        end;

        v15 = v17:FindFirstChild("Stand Right " .. v9);
        v16 = v17:FindFirstChild("Stand Left " .. v9);
    end;

    local u18 = {
        Right = v15,
        Left = v16
    };
    local u19 = {
        Right = {},
        Left = {}
    };

    local function Create(p20) -- Line: 66
        -- upvalues: u18 (copy), u5 (copy), u19 (copy)
        local v21 = u18[p20]:Clone();

        for _, descendant in v21:GetDescendants() do
            if (descendant:IsA("JointInstance") or descendant:IsA("WeldConstraint")) and (descendant.Part0 and descendant.Part0:IsDescendantOf(u5) or descendant.Part1 and descendant.Part1:IsDescendantOf(u5)) then
                local v22 = descendant.Part0 and descendant.Part0:IsDescendantOf(u5) and descendant.Part0:Clone() or descendant.Part1:Clone();
                v22.Parent = v21;

                if descendant.Part0 and descendant.Part0:IsDescendantOf(u5) then
                    descendant.Part0 = v22;
                elseif descendant.Part1 and descendant.Part1:IsDescendantOf(u5) then
                    descendant.Part1 = v22;
                end;
            end;
        end;

        v21:PivotTo(CFrame.new(0, 100000, 0));
        v21.Parent = workspace;
        local v23 = {
            Active = false,
            Model = v21
        };
        table.insert(u19[p20], v23);

        return v23;
    end;

    local function Get(p24) -- Line: 92
        -- upvalues: u19 (copy)
        for _, v in pairs(u19[p24]) do
            if not v.Active then
                return v;
            end;
        end;
    end;

    local function Retrieve(p25) -- Line: 100
        -- upvalues: u19 (copy), Create (copy)
        for _, v in pairs(u19[p25]) do
            if not v.Active then
                break;
            end;
        end;

        return v or Create(p25);
    end;

    local function BarrageEffect() -- Line: 118
        -- upvalues: u1 (ref), u19 (copy), Create (copy), u10 (copy), u8 (copy)
        local v26 = u1:NextInteger(1, 2);
        local v27 = v26 == 1 and "Left" or "Right";

        for _, v in pairs(u19[v27]) do
            if not v.Active then
                break;
            end;
        end;

        local v28 = v or Create(v27);
        local Model = v28.Model;
        v28.Active = true;
        Model.Transparency = 0;
        Model.Anchored = true;

        for _, descendant in pairs(Model:GetDescendants()) do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                descendant.Transparency = 0;
            end;
        end;

        local v29 = u1:NextInteger(0.25, 2) * (v26 == 1 and 1 or -1);
        local v30 = u1:NextInteger(-1, 1.5);
        local v31 = u1:NextInteger(-0.25, 0.25);
        local v32 = u10.CFrame * (u8.Offset or CFrame.identity);
        local v33 = CFrame.new(v29, v30, v31);
        local Angles = CFrame.Angles;
        local v34 = u1:NextNumber(-15, 15);
        local v35 = math.rad(v34);
        local v36 = u1:NextNumber(-10, 10);
        local v37 = v32 * (v33 * Angles(v35, math.rad(v36), 0));
        local v38 = v37 * CFrame.new(0, 0, u1:NextNumber(6.25, 7.25) * -1);
        local v39 = os.clock();
        local v40 = v37 * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);
        local v41 = v38 * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0);

        while os.clock() - v39 <= 0.15 do
            if os.clock() - v39 >= 0.05 then
                local v42 = os.clock() - v39;
                local v43 = math.abs(v42) / 0.09999999999999999;
                local v44 = 0 + 1 * math.clamp(v43, 0, 1);
                Model.Transparency = v44;

                for _, descendant in pairs(Model:GetDescendants()) do
                    if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                        descendant.Transparency = v44;
                    end;
                end;
            end;

            local v45 = os.clock() - v39;
            local v46 = math.abs(v45) / 0.15;
            Model:PivotTo(v40:Lerp(v41, (math.clamp(v46, 0, 1))));
            task.wait();
        end;

        v28.Active = false;
    end;

    local v47 = 0;

    local function Clear(p48) -- Line: 108
        -- upvalues: u19 (copy)
        for _, v in pairs(u19[p48]) do
            if v.Model then
                v.Model:Destroy();
                v.Model = nil;
            end;
        end;
    end;

    while u5 and (u5:IsDescendantOf(workspace) and CollectionService:HasTag(u5, "Barraging")) do
        if os.clock() - v47 >= 0.05 then
            v47 = os.clock();

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