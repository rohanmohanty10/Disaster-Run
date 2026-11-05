  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");

local function LoadAnim(p2, p3) -- Line: 7
    if p2:IsA("AnimationController") then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://" .. p3;

        return p2.Animator:LoadAnimation(Animation);
    end;
end;

return function(u4, p5) -- Line: 18
    -- upvalues: Players (copy), u1 (copy), Debris (copy), TweenService (copy), CollectionService (copy)
    local v6 = Players:GetPlayerFromCharacter(u4);
    local HumanoidRootPart = u4.HumanoidRootPart;
    local _ = u4.Humanoid;
    local u7 = {};
    local u8 = true;
    local Offset = p5.Offset;

    local function CreateFakeArm(p9) -- Line: 31
        -- upvalues: HumanoidRootPart (copy), u1 (ref), u4 (copy), Offset (copy), Debris (ref), u7 (copy), TweenService (ref)
        local v10 = {
            Left = { 10605730966, 10605733233, 10605735227 },
            Right = { 10605740046, 10605738914, 10605737583 }
        };
        local v11 = {
            Left = HumanoidRootPart.CFrame * CFrame.new(math.random(-1, -1.5), math.random(-0.25, 1), math.random(-0.5, 0.5)),
            Right = HumanoidRootPart.CFrame * CFrame.new(math.random(1, 1.5), math.random(-0.25, 1), math.random(-0.5, 0.5))
        };
        local u12 = u1["Jonathan Hamon"][p9 .. "Arm"]:Clone();
        u12.PrimaryPart.Color = u4[p9 .. " Arm"].Color;
        u12.PrimaryPart.Transparency = 1;
        u12.PrimaryPart.CFrame = v11[p9] * Offset;
        u12.Parent = workspace.Effects;
        Debris:AddItem(u12, 3);
        local v13 = math.random(1, 3);

        if u7[p9] == v13 then
            v13 = math.random(1, 3);
        else
            u7[p9] = v13;
        end;

        local AnimationController = u12.AnimationController;
        local v14 = v10[p9][v13];
        local u15;

        if AnimationController:IsA("AnimationController") then
            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://" .. v14;
            u15 = AnimationController.Animator:LoadAnimation(Animation);
        else
            u15 = nil;
        end;

        u15:Play();
        local u16 = nil;
        u16 = u15:GetMarkerReachedSignal("End"):Connect(function() -- Line: 69
            -- upvalues: u16 (ref), TweenService (ref), u12 (copy)
            u16:Disconnect();
            TweenService:Create(u12.PrimaryPart, TweenInfo.new(0.1), {
                Size = Vector3.new()
            }):Play();
        end);
        task.spawn(function() -- Line: 75
            -- upvalues: u12 (copy), u15 (copy)
            task.wait(0.085);
            u12.PrimaryPart.Transparency = 0;
            u15.Stopped:Wait();
            u15:Destroy();
            u12:Destroy();
        end);
    end;

    if v6 then
        local u17 = nil;
        u17 = v6.CharacterRemoving:Connect(function() -- Line: 89
            -- upvalues: u17 (ref), u8 (ref)
            u17:Disconnect();

            if u8 then
                u8 = false;
            end;
        end);
    end;

    repeat
        task.spawn(function() -- Line: 99
            -- upvalues: CreateFakeArm (copy)
            CreateFakeArm("Left");
            CreateFakeArm("Right");
        end);
        task.wait(0.0325);
    until not u8 or (not CollectionService:HasTag(u4, "Barraging") or (u4.Humanoid.Health <= 0 or u4 == nil));
end;