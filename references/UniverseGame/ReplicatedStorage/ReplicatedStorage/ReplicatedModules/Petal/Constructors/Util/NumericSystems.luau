  

 

return {
    Base2 = {
        from = function(p1) -- Line: 4, Name: from
            return tonumber(p1, 2);
        end,

        to = function(p2) -- Line: 7, Name: to
            local v3 = {};

            while p2 > 0 do
                local v4 = p2 % 2;
                table.insert(v3, 1, v4);
                p2 = (p2 - v4) / 2;
            end;

            return table.concat(v3);
        end
    },
    Base8 = {
        from = function(p5) -- Line: 23, Name: from
            return tonumber(p5, 8);
        end,

        to = function(p6) -- Line: 26, Name: to
            return string.format("%o", p6);
        end
    },
    Base16 = {
        from = function(p7) -- Line: 33, Name: from
            local v8 = "0x" .. tostring(p7);

            return tonumber(v8);
        end,

        to = function(p9) -- Line: 36, Name: to
            return string.format("%X", p9);
        end
    }
};