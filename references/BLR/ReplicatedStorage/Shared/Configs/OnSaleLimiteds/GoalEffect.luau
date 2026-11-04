  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Assets = ReplicatedStorage.Assets;
local VfxManager = require(ReplicatedStorage.VfxManager);

local function spawnRig(p1, p2) -- Line: 6
    local u3 = p1:Clone();
    u3.Parent = p2;
    u3:PivotTo(p2.Origin.CFrame * p2.Origin.CFrame:ToObjectSpace(p1:GetPivot()));

    for _, descendant in u3:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.Anchored = false;
            descendant.Massless = true;
        end;
    end;

    if u3.PrimaryPart then
        u3.PrimaryPart.Anchored = true;
    end;

    local v4 = u3:FindFirstChildWhichIsA("AnimationController");
    local v5 = u3:FindFirstChildWhichIsA("Animation");

    if not (v4 and v5) then
        task.delay(8, function() -- Line: 34
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);

        return;
    end;

    local v6 = v4:LoadAnimation(v5);
    v6.Looped = false;
    v6:Play();
    v6.Stopped:Once(function() -- Line: 30
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;

return function(p7: string, p8: any, p9: any) -- Line: 40
    -- upvalues: Assets (copy), ReplicatedStorage (copy), CollectionService (copy), VfxManager (copy), spawnRig (copy)
    return {
        Type = "GoalEffect",
        HeaderOffset = 8,
        Name = p7,
        ProductId = p8,
        GiftProductId = p9,
        Gradient = script.GoalEffectGradient,

        LoadVisual = function(p10: any, u11: userdata) -- Line: 48, Name: LoadVisual
            -- upvalues: Assets (ref), ReplicatedStorage (ref), CollectionService (ref), VfxManager (ref), spawnRig (ref)
            local v12 = Assets.LimitedTemplates.GoalTemplate:Clone();
            v12:PivotTo(u11.Origin.CFrame);
            v12.Origin.Transparency = 1;
            v12.Parent = u11;

            if p10.Name == "Eagle Roar" then
                v12:ScaleTo(v12:GetScale() * 0.45);
                v12:PivotTo(u11.Origin.CFrame * CFrame.new(0, 0, 1.5));
                local u13 = require(ReplicatedStorage.Effects.GoalEffects["Eagle Roar"]);
                task.spawn(function() -- Line: 58
                    -- upvalues: u11 (copy), u13 (copy)
                    while u11:IsDescendantOf(workspace) do
                        u13({
                            IsPodiumPreview = true,
                            Pos = u11.Origin.CFrame * CFrame.new(0, 0, 1.5) * CFrame.Angles(0, 1.5707963267948966, 0),
                            Parent = u11
                        });
                        task.wait(13);
                    end;
                end);

                return;
            end;

            local vfx = u11.ManualGoalEffect.vfx;
            local u14 = {};

            for _, descendant in vfx:GetDescendants() do
                if CollectionService:HasTag(descendant, "GoalEffectRig") then
                    descendant.Parent = nil;
                    table.insert(u14, descendant);
                end;
            end;

            task.spawn(function() -- Line: 83
                -- upvalues: VfxManager (ref), vfx (copy), u14 (copy), spawnRig (ref), u11 (copy)
                while true do
                    VfxManager.Emit(vfx);

                    for _, v in u14 do
                        spawnRig(v, u11);
                    end;

                    task.wait(VfxManager.MaxLifetime(vfx) + 1);
                end;
            end);
        end
    };
end;