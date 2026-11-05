  

 

local TweenService = game:GetService("TweenService");
local u1 = Random.new();
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p2) -- Line: 7
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy), TweenService (copy)
    local Origin = p2.Origin;
    local Duration = p2.Duration;
    local HSVShift = p2.HSVShift;
    local v3 = os.clock();
    local u4 = AssetHandler.CloneAsset("Particles/SuperiorSlash/Swirl", {
        AbilityName = "Gryphon"
    });
    local ShockMain = u4.ShockMain;

    if HSVShift then
        for _, child in u4:GetChildren() do
            if child:IsA("BasePart") then
                child.Color = ParticleHandler.HSVShift(child.Color, HSVShift);
            end;
        end;
    end;

    ShockMain.CFrame = Origin * CFrame.Angles(0, 3.141592653589793, 0);
    local Orientation = ShockMain.Orientation;
    local v5 = u1:NextNumber(-360, 360);
    ShockMain.Orientation = Orientation + Vector3.new(0, v5, 0);
    u4.Parent = workspace.Effects;

    for _, child in u4:GetChildren() do
        if child:IsA("BasePart") then
            TweenService:Create(child, TweenInfo.new(0.5), {
                Transparency = 0
            }):Play();
        end;
    end;

    task.delay(Duration, function() -- Line: 35
        -- upvalues: u4 (copy), TweenService (ref)
        for _, child in u4:GetChildren() do
            if child:IsA("BasePart") then
                TweenService:Create(child, TweenInfo.new(0.5), {
                    Transparency = 1
                }):Play();
            end;
        end;

        task.delay(0.75, u4.Destroy, u4);
    end);

    while os.clock() - v3 < Duration + 0.75 do
        ShockMain.CFrame = ShockMain.CFrame * CFrame.Angles(0, -0.17453292519943295, 0);
        task.wait(0.01);
    end;
end;