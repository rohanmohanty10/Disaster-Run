  

 

return {
    s_dcores = {
        DisplayName = "Cores",

        Description = function(p1) -- Line: 6, Name: Description
            local v2 = p1.Metadata.Stacks or 1;

            return `You're empowered by a strange force.<br /><b> +{2.5 * v2}% increased damage</b> (2.5% per stack)<br /> <b> -{2 * v2}% incoming damage</b> (2% per stack)`;
        end,

        Priority = require("../StatusIndicatorEnums").Priority.Passive
    }
};