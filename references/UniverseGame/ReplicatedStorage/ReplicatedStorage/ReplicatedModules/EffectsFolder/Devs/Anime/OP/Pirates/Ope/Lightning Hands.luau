  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = Random.new();

return function(p2, p3, p4, p5) -- Line: 9
    -- upvalues: EffectsHandler (copy), u1 (copy)
    local Model = Instance.new("Model");
    Model.Name = "Lightning";
    Model.Parent = workspace.CurrentCamera;

    if p5 then
        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.OutlineTransparency = 1;
        Highlight.FillTransparency = 0;
        Highlight.FillColor = Color3.new(1, 1, 1);
        Highlight.Parent = Model;
    end;

    task.delay(p3 + 1.5, Model.Destroy, Model);
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = p2["Left Arm"];
    Attachment.Position = Vector3.new(0, -1, 0);
    task.delay(p3 + 1.5, Attachment.Destroy, Attachment);
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = p2["Right Arm"];
    Attachment2.Position = Vector3.new(0, -1, 0);
    task.delay(p3 + 1.5, Attachment2.Destroy, Attachment2);
    local v6 = os.clock();
    local v7 = 1;

    while p2:IsDescendantOf(game) and os.clock() - v6 < p3 do
        EffectsHandler.CallEffect("Generate Quasiduck Lightning", p2, {
            Size = 0.17,
            MaxRadius = 1.2,
            Color = ColorSequence.new(p4[v7 % #p4 + 1]),
            Speed = u1:NextNumber(6, 8.5),
            A1 = Attachment,
            A2 = Attachment2,
            Parent = Model
        });
        v7 = v7 + 1;
        task.wait(0.0225);
    end;
end;