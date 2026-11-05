  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
ReplicatedStorage:FindFirstChild("Client Assets");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local TableUtil = require(ReplicatedStorage.ReplicatedModules.KnitPackage.TableUtil);
local u1 = Random.new();

return function(u2) -- Line: 16
    -- upvalues: TableUtil (copy), u1 (copy), EffectsHandler (copy)
    local Part = u2.Part;

    if not Part then
        return;
    end;

    local v3 = typeof(Part) == "table" and Part and Part or {
        [Part] = 0
    };
    local u4 = u2.Lifetime or 1;
    local u5 = u2.LightningLength or 0.85;
    local Outline = u2.Outline;
    local u6 = u2.Offset or CFrame.identity;
    local u7 = u2.SizeRange or Vector2.new(15, 30);
    local u8 = TableUtil.Reconcile(u2.Ranges or {}, {
        X = NumberRange.new(-5, 5),
        Y = NumberRange.new(-5, 5),
        Z = NumberRange.new(-5, 5)
    });
    local u9 = u2.Attribute or "ActiveLightning";
    local Model = Instance.new("Model");
    Model.Name = "Lightning";
    Model.Parent = workspace.CurrentCamera;

    if Outline then
        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.OutlineTransparency = 1;
        Highlight.FillTransparency = 0;
        Highlight.FillColor = Outline;
        Highlight.Parent = Model;
    end;

    task.delay(u4 + 2, Model.Destroy, Model);
    local u10 = os.clock();

    for i, v in v3 do
        task.delay(typeof(v) == "number" and v and v or 0, function() -- Line: 46
            -- upvalues: u2 (copy), i (copy), u6 (copy), u1 (ref), u8 (copy), EffectsHandler (ref), TableUtil (ref), u5 (copy), u7 (copy), Model (copy), u10 (copy), u4 (copy), u9 (copy)
            repeat
                local v11 = u2.Origin or i.CFrame;
                local v12 = v11 * CFrame.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2)) * u6;
                local v13 = v11 * CFrame.new(u1:NextNumber(u8.X.Min, u8.X.Max), u1:NextNumber(u8.Y.Min, u8.Y.Max), u1:NextNumber(u8.Z.Min, u8.Z.Max));
                EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, TableUtil.Reconcile(u2.Lightning or {}, {
                    PartCount = 6,
                    Color = ColorSequence.new(Color3.fromRGB(255, 0, 0)),
                    Speed = 1 / (math.random(5, 15) / 100),
                    Length = u5,
                    Transparency = u2.Transparency or NumberRange.new(0, 0),
                    CFrames = { v12, v13 },
                    Size = math.random(u7.X, u7.Y) / 100,
                    Parent = Model
                }));
                task.wait(u2.Interval or u1:NextNumber(0.0075, 0.01));
            until u4 <= os.clock() - u10 or not (i:IsDescendantOf(game) and i:GetAttribute(u9));
        end);
    end;
end;