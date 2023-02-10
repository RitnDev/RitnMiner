if ritnmods.miner.dectorio then 
    -- Gavel make on crusher
    for _,recipe in pairs(data.raw["recipe"]) do 
        if string.sub(recipe.name,1,5) == "dect-"
        and string.sub(recipe.name,-7) == "-gravel" then 
            recipe.category = "ritn-crushing"
        end
    end
end