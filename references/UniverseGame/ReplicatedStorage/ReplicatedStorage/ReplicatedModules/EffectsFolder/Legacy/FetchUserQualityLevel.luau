  

 

return function() -- Line: 1
    local SavedQualityLevel = UserSettings().GameSettings.SavedQualityLevel;

    return (SavedQualityLevel == Enum.SavedQualitySetting.Automatic and 5 or SavedQualityLevel.Value) / 10;
end;