  

 

local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local CollectionService = game:GetService("CollectionService");
local u2 = {};
local u3 = {};
local TweenService = game:GetService("TweenService");
local u4 = nil;

local function Weld(p5, p6, p7, p8) -- Line: 8
    local v9 = p5:FindFirstChild("Weld") or Instance.new("Weld");
    v9.Parent = p5;
    v9.Part0 = p5;
    v9.Part1 = p6;
    v9.C0 = p7 or CFrame.new();
    v9.C1 = p8 or CFrame.new();
end;

local u10 = true;
task.spawn(function() -- Line: 18
    -- upvalues: u10 (ref)
    local StunIndicator = game.Players.LocalPlayer:WaitForChild("Settings"):WaitForChild("StunIndicator");
    StunIndicator.Changed:Connect(function(p11) -- Line: 21
        -- upvalues: u10 (ref)
        u10 = p11;
    end);
    u10 = StunIndicator.Value;
end);
CollectionService:GetInstanceRemovedSignal("Stunned"):Connect(function(p12) -- Line: 27
    -- upvalues: u3 (copy)
    local v13 = u3[p12];

    if v13 then
        u3[p12] = nil;
        task.spawn(v13);
    end;
end);

return function(u14) -- Line: 35
    -- upvalues: u10 (ref), u2 (copy), u1 (copy), u4 (ref), Weld (copy), CollectionService (copy), u3 (copy), TweenService (copy)
    if u10 ~= true then
        return;
    end;

    if u2[u14] then
        return;
    end;

    if not (u14 and u14:IsDescendantOf(workspace)) then
        return;
    end;

    local u15 = u1.Misc.DMGGUI:Clone();
    u2[u14] = true;
    u15.Anchored = false;
    u4 = u14.AncestryChanged:Connect(function() -- Line: 45
        -- upvalues: u4 (ref), u2 (ref), u14 (copy), u15 (copy)
        u4:Disconnect();
        u2[u14] = nil;
        u15:Destroy();
    end);
    pcall(function() -- Line: 51
        -- upvalues: u15 (copy), Weld (ref), u14 (copy), CollectionService (ref), u3 (ref)
        local bg = u15.bg;
        bg.Size = UDim2.fromScale(5, 1.5);
        bg.StudsOffset = Vector3.new(0, 5, 0);
        bg.tl.Text = "STUNNED";
        Weld(u15, u14.HumanoidRootPart);
        u15.Parent = workspace.Effects;

        while CollectionService:HasTag(u14, "Stunned") do
            u3[u14] = coroutine.running();
            coroutine.yield();
        end;
    end);

    if u15 and (u15.Parent and u15:FindFirstChild("bg")) then
        TweenService:Create(u15.bg.tl, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
    end;

    task.delay(0.08, function() -- Line: 77
        -- upvalues: u15 (copy)
        u15:Destroy();
    end);
    u2[u14] = nil;
end;