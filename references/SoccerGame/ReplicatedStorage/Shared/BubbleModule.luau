  

local TweenService = game:GetService("TweenService");

return {
    CreateBubble = function(p1, p2, p3, p4, p5) -- Line: 5, Name: CreateBubble
        -- upvalues: TweenService (copy)
        local v6 = script.Mesh:Clone();
        v6.CFrame = p1;
        v6.Anchored = true;
        v6.CanCollide = false;
        v6.Massless = true;
        v6.Parent = workspace.Debris;
        v6.Material = Enum.Material.Glass;
        v6.Size = p2;
        v6.Transparency = p3;
        local Highlight = Instance.new("Highlight");
        Highlight.Enabled = false;
        Highlight.Parent = v6;
        game.Debris:addItem(v6, p5);
        TweenService:Create(v6, TweenInfo.new(p5), {
            Transparency = 1,
            Size = p4
        }):Play();

        return v6;
    end
};