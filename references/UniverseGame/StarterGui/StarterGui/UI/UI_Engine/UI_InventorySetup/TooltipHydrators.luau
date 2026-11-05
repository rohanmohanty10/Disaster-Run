  

 

return {
    ITEM_900 = function(p1) -- Line: 16
        local v2 = p1.Metadata and p1.Metadata.Clearance or 0;

        return `<br /><font color="#{Color3.fromRGB(255, 171, 75):ToHex()}">Clearance Level: {v2}</font>`;
    end
};