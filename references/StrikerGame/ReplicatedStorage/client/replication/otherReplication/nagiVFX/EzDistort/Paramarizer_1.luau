 
 

require(script.Parent.SharedTypes);

return {
    newNamedDistortionMatrix = function(p1) -- Line: 9, Name: newNamedDistortionMatrix
        local v2 = p1 or {};

        return {
            ScaleX = v2.ScaleX,
            ScaleY = v2.ScaleY,
            ShearX = v2.ShearX,
            ShearY = v2.ShearY,
            StretchX = v2.StretchX,
            StretchY = v2.StretchY,
            TranslationX = v2.TranslationX,
            TranslationY = v2.TranslationY,
            Zoom = v2.Zoom
        };
    end,

    newDistortionPresetParams = function(p3) -- Line: 27, Name: newDistortionPresetParams
        local v4 = p3 or {};

        return {
            DistortionParams = v4.DistortionParams,
            OnCreate = v4.OnCreate or function() -- Line: 33
            end,
            OnDestroying = v4.OnDestroying or function() -- Line: 37
            end
        };
    end,

    newDistortionParams = function(p5) -- Line: 45, Name: newDistortionParams
        local v6 = p5 or {};

        return {
            EaseTime = v6.EaseTime or 0.1,
            FadeoutTime = v6.FadeoutTime or 0.15,
            Priority = v6.Priority or 1,
            DisableClamps = v6.DisableClamps or false,
            TargetCamera = v6.TargetCamera
        };
    end
};