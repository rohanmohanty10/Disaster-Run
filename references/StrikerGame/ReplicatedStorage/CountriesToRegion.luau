 

 

local u1 = {
    Europe = { "AL", "AD", "AT", "BY", "BE", "BA", "BG", "HR", "CZ", "DK", "EE", "FI", "FR", "DE", "GR", "HU", "IS", "IE", "IT", "LV", "LI", "LU", "MT", "MD", "MC", "ME", "NO", "PL", "PT", "RO", "RU", "SM", "RS", "SK", "SI", "ES", "SE", "CH", "TR", "UA", "GB", "NL" },
    ["North America"] = { "US", "CA", "AG", "BS", "BB", "BZ", "SV", "NI", "GD", "GT", "PA", "CR", "CU", "HT", "HN", "KN", "LC", "VC", "JM", "TT", "MX", "DM", "DO" },
    ["South America"] = { "AR", "BO", "BR", "CL", "CO", "EC", "GY", "PY", "PE", "SR", "UY", "VE", "FK", "GF", "GS" },
    Asia = { "CN", "IN", "KZ", "SA", "IR", "MN", "ID", "PK", "MM", "AF", "YE", "TH", "TM", "UZ", "IQ", "JP", "VN", "MY", "OM", "PH", "LA", "KG", "SY", "KH", "BD", "NP", "TJ", "KP", "KR", "JO", "AE", "AZ", "GE", "LK", "EG", "BT", "TW", "AM", "IL", "KW", "TL", "QA", "LB", "CY", "PS", "BN", "HK", "BH", "SG", "MV", "MO" },
    Africa = { "DZ", "AO", "BJ", "BW", "BF", "BI", "CM", "CF", "CG", "CD", "DJ", "EG", "GQ", "ER", "ET", "GA", "GM", "GH", "GN", "GW", "KE", "LS", "LR", "LY", "MG", "MW", "ML", "MR", "MU", "MA", "MZ", "NA", "NE", "NG", "RW", "ST", "SN", "SC", "SL", "SO", "ZA", "SS", "TZ", "TG", "TN", "UG", "ZM", "ZW" },
    ["Australia and Oceania"] = { "AU", "FJ", "KI", "MH", "FM", "NR", "NZ", "PW", "PG", "WS", "TO", "TV", "VU", "AS", "CK", "PF", "GU", "NC", "NU", "NF", "MP", "PN", "TK", "WF" }
};

return {
    Convert = function(p2) -- Line: 224, Name: ConvertCountrytoRegion
        -- upvalues: u1 (copy)
        for i, v in u1 do
            if table.find(v, p2) then
                return i;
            end;
        end;

        return "???";
    end,

    Map = u1
};