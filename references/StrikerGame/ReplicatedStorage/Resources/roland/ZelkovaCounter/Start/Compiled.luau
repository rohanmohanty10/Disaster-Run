 

 

local TweenService = game:GetService("TweenService");
local TweenInfo_new_ret = TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut);
local TweenInfo_new_ret2 = TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Back, Enum.EasingDirection.In);

local function set_weapons(p1, p2) -- Line: 6
    for _, v in { "ZelAxe", "ZelMace" } do
        for _, child in p1[v]:GetChildren() do
            child.Transparency = p2;
        end;
    end;
end;

return {
    { 0, function(p3, p4) -- Line: 16
            -- upvalues: set_weapons (copy), TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
            set_weapons(p4, 1);
            TweenService:Create(p4.ZelkovaHighlight, TweenInfo_new_ret, {
                FillTransparency = 1
            }):Play();
            TweenService:Create(p4.ZelkovaHighlight, TweenInfo_new_ret2, {
                OutlineTransparency = 1
            }):Play();
        end },
    { 20, function(p5, p6) -- Line: 23
            -- upvalues: set_weapons (copy)
            set_weapons(p6, 0);
            shared.vfx.emit(p6.ZelAxe);
            shared.vfx.emit(p6.ZelMace);
        end },
    { 25, function(p7, p8) -- Line: 30
            shared.vfx.emit(p8.HumanoidRootPart.ZelkovaVFX);
        end }
};