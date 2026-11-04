  

return function(p1: any, p2: userdata, p3: boolean) -- Line: 1
    p2:SetAttribute("GemSkinOverride", p3);

    return `Gem skin {p3 and "on" or "off"} for {p2.Name}`;
end;