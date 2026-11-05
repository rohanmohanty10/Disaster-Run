  

 

local ViewportFrame = game.Players.LocalPlayer.PlayerGui.UI.Menus.Skins.ViewportFrame;

local function C(p1, p2, p3) -- Line: 3
    p2:PivotTo(CFrame.new(0, 0, 0));
end;

local _ = ViewportFrame.Camera;
ViewportFrame.WorldModel.Model:PivotTo(CFrame.new(0, 0, 0));