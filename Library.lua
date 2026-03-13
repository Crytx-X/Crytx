local Globals = getgenv()

if not game:IsLoaded() then game.Loaded:Wait() end

-- // Services & Main Refs
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PathfindingService = game:GetService("PathfindingService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local PlayersService = game:GetService("Players")

local RemoteFunc = ReplicatedStorage:WaitForChild("RemoteFunction")
local RemoteEvent = ReplicatedStorage:WaitForChild("RemoteEvent")
local LocalPlayer = PlayersService.LocalPlayer or PlayersService.PlayerAdded:Wait()
local mouse = LocalPlayer:GetMouse()
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local FileName = "ADS_Config.json"

-- // Data Tables (Skins Simplified - No RBXAssetIDs)
local TowerSkins = {
    ["Accelerator"] = {"Champion", "Cupid", "Dank", "Default", "Disco", "Ducky", "Eclipse", "Elite", "Fallen", "Ghost Buster", "Ice Witch", "Legend", "Mage", "Magician", "Navy", "Nuclear", "Octopus", "Patient Zero", "Plushie", "Red", "Senator", "Speaker Titan", "Vigilante"},
    ["Ace Pilot"] = {"Aerial Ace", "Default", "Easter", "Green", "Navy", "Pumpkin", "Purple", "Red", "Toy Plane", "Yellow"},
    ["Archer"] = {"Default", "Elf", "Huntsman", "Ice Soul", "Spooky", "Valentines"},
    ["Assassin"] = {"Actor", "Default", "Saber Tooth Tiger"},
    ["Biologist"] = {"Default", "Grim"},
    ["Brawler"] = {"Banned", "Blazing", "Default", "Fallen", "Horse", "Jordan", "Loader", "Lobster", "Lovestriker", "Rudolph", "Werewolf"},
    ["Combatant"] = {"Default"},
    ["Commander"] = {"Aqua", "Bloxy", "Brisk", "Bunny", "Candy Cane", "Default", "Director", "Ducky", "Eclipse", "Eggrypted", "Fallen", "Frost", "Galactic", "Gargoyle", "General", "Ghost", "Green", "Holiday", "Lifeguard", "Maid", "Neko", "Patriotic", "Pattern", "Phantom", "Pirate", "Plushie", "Red", "Santa", "Spring Time", "Umbra", "Valentines", "Victorian", "Vigilante", "War Lord", "Wasteland", "Werewolf", "Wonderland"},
    ["Commando"] = {"Default", "Pirate", "Trooper"},
    ["Cowboy"] = {"Agent", "Badlands", "Bandit", "Bounty Hunter", "Cop", "Cyberpunk", "Dark Frost", "Default", "Ducky", "Fallen", "Golden", "Holiday", "Kasodus", "Masquerade", "Mecha Bunny", "Megalodon", "Noir", "Plushie", "Pumpkin", "Redemption", "Retired", "Spring Time", "Valentines", "Vampire Hunter"},
    ["Crook Boss"] = {"Alien Focus", "Assassin", "Blue", "Checker", "Corso", "Cupid", "Cybernetic", "DRKSHDW", "Dark Frost", "Default", "Demon", "Easter", "Game Master", "Golden", "Holiday", "Intern", "Narrator", "Necromancer", "Null", "Pirate", "Rat King", "Red", "Soviet", "Spooky", "SteamPunk", "Victorian", "Xmas"},
    ["Cryomancer"] = {"Default", "Krampus Slayer"},
    ["DJ Booth"] = {"Default", "Ducky", "Garage Band", "Ghost", "Gingerbread", "Mako", "Masquerade", "Neko", "Neon Rave", "Plushie", "Seal"},
    ["Demoman"] = {"Blue", "Default", "Ducky", "Fortress", "Ghost", "Green", "Military", "Pirate", "Pumpkin", "Red", "Yellow"},
    ["Electroshocker"] = {"Banned", "Bunny", "Classic", "Dark Frost", "Default", "Ducky", "Frankenstein", "Ghost", "Hazmat", "Jellyfish", "Korblox", "Lovestriker", "TeeVee", "Valentines", "Vigilante"},
    ["Elementalist"] = {"Default"},
    ["Elf Camp"] = {"Chocolatier", "Classic", "Default"},
    ["Engineer"] = {"Beach", "Dark Frost", "Default", "DraxRex", "Ducky", "Fallen", "Ghost", "Grave Digger", "Heartbreak", "Holiday", "Mechanic", "Phantom", "Plushie", "Wikia"},
    ["Executioner"] = {"Default", "Eclipse", "Heartbreak", "Vanquisher"},
    ["Farm"] = {"Arcade", "Booth", "Cinema", "Cozy Camp", "Crab", "Crypto", "Cube", "Default", "Ducky", "Graveyard", "Lemonade Stand", "Null Soul", "PNG", "Pirate", "Present", "Tycoon", "Vendor", "Wasteland", "Xmas"},
    ["Firework Technician"] = {"2026", "Default", "Inventor"},
    ["Freezer"] = {"Cryptid", "Deep Freeze", "Default", "Foam", "Frost Legion", "IcyTea", "Mint Choco", "Polar Bear", "Vendor"},
    ["Frost Blaster"] = {"Default"},
    ["Gatling Gun"] = {"Default", "Easter"},
    ["Gladiator"] = {"Beach", "Cameraman", "Default", "Demon", "Galactic", "Phantom", "Pirate", "Pumpkin", "Slugger", "Umbrella", "Vigilante"},
    ["Hacker"] = {"Camera Operator", "Default", "Fallen", "Reindeer Mech", "Triumphant"},
    ["Hallow Punk"] = {"Default", "Lunar"},
    ["Harvester"] = {"Default", "Lunar", "Wasteland"},
    ["Hunter"] = {"Blue", "Default", "Ducky", "Halloween", "Pirate", "Vampire Slayer"},
    ["Jester"] = {"Clown", "Default", "Heartbreak", "The Beast", "The Flea"},
    ["Juggernaut"] = {"Default"},
    ["Kingpin"] = {"Default"},
    ["Mecha Base"] = {"Default"},
    ["Medic"] = {"Bartender", "Bunny", "Cyber", "Default", "Fallen", "Masquerade", "Mermaid", "Plague", "Second Chance", "Stranded", "Toy Ballerina", "Valentines", "Witch"},
    ["Mercenary Base"] = {"Default", "Frost Legion", "Graveyard", "Liberator"},
    ["Militant"] = {"Ace Pilot", "Acheron", "Arsenal", "Beach", "Chocolatier", "Davinchi", "Default", "Ducky", "Easter", "Fallen", "Ghost", "Hazmat", "John", "Lumberjack", "Pumpkin", "Star Spartan", "Undead", "Wasteland"},
    ["Military Base"] = {"Base 1776", "Classic", "Cyber", "Default", "Wasteland"},
    ["Minigunner"] = {"Beach", "Black Ops", "Blue", "Bunny", "Chad", "Chocolatier", "Community", "Crusader", "Cursed", "Default", "Ducky", "Fallen", "Frost", "Gardener", "Ghost", "Golden", "Golden Plushie", "Green", "Hazmat", "Heavy", "Holiday", "Nutcracker", "Ox", "Party", "Phantom", "Plushie", "Pumpkin", "Road Rage", "Space Elite", "Sweaking", "Toy", "Trucker", "Twitter", "Warlord", "Wraith", "Xmas"},
    ["Mortar"] = {"Baseball", "Bunny", "Dark Frost", "Default", "DefaultOld", "Defender", "Ducky", "Eclipse", "Fallen", "Festive", "Frost", "Krampus", "Mecha Ducky", "Pirate", "Valentines", "Vigilante"},
    ["Necromancer"] = {"Creepy Santa", "Default", "Duck", "Fallen", "Mage"},
    ["Operator"] = {"Default"},
    ["Paintballer"] = {"Bunny", "Default", "Green", "Red"},
    ["Pursuit"] = {"Default", "Dragon", "Eggy"},
    ["Pyromancer"] = {"Acidic", "Barbecue", "Blue", "Bunny", "Default", "Dwarf", "Fire Breather", "Frost", "Ghost", "Golden", "Hallow Punk", "Hazmat", "Mage", "Plushie", "Pool Party", "Reindeer", "Scarecrow", "Valentines", "Vigilante"},
    ["Ranger"] = {"5ouls", "Badlands", "Beast Slayer", "Black Ops", "Blue", "Bunny", "Classic", "Dark Matter", "Default", "Eclipse", "Eskimo", "Frankenstein", "Frost", "Green", "Gun Gale", "Mecha Ducky", "Partisan", "Phantom", "Propellars", "Pumpkin", "Railgunner", "Shark", "SteamPunk", "Valentines", "Wraith"},
    ["Rocketeer"] = {"Bosanka", "Dark Matter", "Default", "Duck", "Fortress", "Ghost", "Lovestriker", "Lunar", "Pumpkin", "Steampunk", "Toy", "Trombone", "Xmas"},
    ["Scout"] = {"Banned", "Beach", "Black Ops", "Blue", "Bunny", "Cookie", "Default", "Ducky", "Eclipse", "Fallen", "Frost Hunter", "Golden", "Green", "Guest", "Haz3mn", "Holiday", "Intern", "King of Rock", "Masquerade", "Party", "Penguin", "Phantom", "Plushie", "Prime Raven", "Red", "Shark", "Skull Trooper", "Survivor", "Toilet", "Valentines", "Valhalla"},
    ["Shotgunner"] = {"Classic", "Dance Fever", "Default", "Ducky", "Gardener", "Hallow Punk", "Holiday", "Null", "Phantom", "Slayer", "Spooky", "Trumpeter", "Vigilante"},
    ["Slasher"] = {"Default", "Jason", "Spooky", "Spring Time"},
    ["Sledger"] = {"Brave Soul", "Chocolatier", "Default", "Fallen", "Phantom"},
    ["Sniper"] = {"Blue", "Bunny", "Davinchi", "Default", "Ducky", "Frost Legion", "Ghillie", "Red", "Redemption", "Shrimp", "Silent", "Valentines"},
    ["Snowballer"] = {"Default"},
    ["Soldier"] = {"Aerobics", "Beast Slayer", "Blue", "Bunny", "Classic", "Cold Soldier", "Dark Frost", "Default", "Doughboy", "Ducky", "Golden", "Grand Theft", "Holiday", "Korblox", "Liberator", "Null", "Party", "Red", "Stealth Ops", "Toilet", "Toy", "Valentines"},
    ["Spotlight Tech"] = {"Default"},
    ["Swarmer"] = {"Default"},
    ["Tesla"] = {"Default"},
    ["Toxic Gunner"] = {"Default", "Phantom"},
    ["Trapper"] = {"Banned", "Chocolatier", "Dark Frost", "Default", "Hermit", "Holiday", "Jolly Tree", "Mallard Duck", "Plushie"},
    ["Turret"] = {"Crossbow", "Default", "Grinch", "Jetski", "XR300", "XR500"},
    ["War Machine"] = {"Default"},
    ["Warden"] = {"Baseball", "Dark Frost", "Default", "Ducky", "Fallen", "Freddy", "Galactic", "Isaac", "Korblox", "Masquerade", "Pirate", "Shark", "Slaughter"},
    ["Warlock"] = {"Default", "Rockstar", "Tiger"}
}

-- // Tower Resolver Logic
local ValidTowersList = {
    "Scout", "Sniper", "Paintballer", "Demoman", "Hunter", "Soldier", "Militant",
    "Freezer", "Assassin", "Shotgunner", "Pyromancer", "Ace Pilot", "Medic", "Farm",
    "Rocketeer", "Trapper", "Military Base", "Crook Boss",
    "Electroshocker", "Commander", "Warden", "Cowboy", "DJ Booth", "Minigunner",
    "Ranger", "Pursuit", "Gatling Gun", "Turret", "Mortar", "Mercenary Base",
    "Brawler", "Necromancer", "Accelerator", "Engineer", "Hacker",
    "Gladiator", "Commando", "Slasher", "Frost Blaster", "Archer", "Swarmer",
    "Toxic Gunner", "Sledger", "Executioner", "Elf Camp", "Jester", "Cryomancer",
    "Hallow Punk", "Harvester", "Snowballer", "Elementalist",
    "Firework Technician", "Biologist", "Warlock", "Spotlight Tech", "Mecha Base"
}

local function NormalizeString(s) return s:lower():gsub("[^a-z0-9]", "") end

local NormalizedTowers = {}
for _, name in ipairs(ValidTowersList) do
    table.insert(NormalizedTowers, {
        raw = name,
        norm = NormalizeString(name),
        words = name:lower():split(" ")
    })
end

local function ResolveTowerName(input)
    if input == "" then return end
    local n = NormalizeString(input)
    for _, t in ipairs(NormalizedTowers) do if t.norm == n then return t.raw end end
    for _, t in ipairs(NormalizedTowers) do if t.norm:sub(1, #n) == n then return t.raw end end
    for _, t in ipairs(NormalizedTowers) do
        for _, w in ipairs(t.words) do
            if w:sub(1, #n) == n then return t.raw end
        end
    end
    return nil
end

-- // Anti-Idle & Auto Reconnect
task.spawn(function()
    local success, connections = pcall(getconnections, LocalPlayer.Idled)
    if success then
        for _, v in pairs(connections) do v:Disable() end
    end
end)

task.spawn(function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new(0, 0))
    end)
end)

task.spawn(function()
    local CoreGui = game:GetService("CoreGui")
    local overlay = CoreGui:WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay")
    overlay.ChildAdded:Connect(function(child)
        if child.Name == 'ErrorPrompt' then
            while true do
                TeleportService:Teleport(3260590327)
                task.wait(5)
            end
        end
    end)
end)

local function IdentifyGameState()
    local TempGui = LocalPlayer:WaitForChild("PlayerGui")
    while true do
        if TempGui:FindFirstChild("ReactLobbyHud") then return "LOBBY"
        elseif TempGui:FindFirstChild("ReactUniversalHotbar") then return "GAME" end
        task.wait(1)
    end
end
local GameState = IdentifyGameState()

local function StartAntiAfk()
    task.spawn(function()
        local LobbyTimer = 0
        while GameState == "LOBBY" do 
            task.wait(1)
            LobbyTimer = LobbyTimer + 1
            if LobbyTimer >= 600 then
                TeleportService:Teleport(3260590327)
                break 
            end
        end
    end)
end
StartAntiAfk()

-- // Network Functions
local SendRequest = request or http_request or httprequest or (GetDevice and GetDevice().request)
if not SendRequest then warn("failure: no http function") return end

-- // Variables & Toggles
local BackToLobbyRunning = false
local AutoSkipRunning = false
local AntiLagRunning = false
local AutoChainRunning = false
local AutoDjRunning = false
local AutoNecroRunning = false
local TimeScaleRunning = false
local TimeScaleNoTicketsWarned = false
local AutoMercenaryBaseRunning = false
local AutoMilitaryBaseRunning = false
local SellFarmsRunning = false

local MaxPathDistance = 300 
local MilMarker = nil
local MercMarker = nil
local CurrentEquippedTowers = {"None"}
local StackEnabled = false
local SelectedTower = nil
local StackSphere = nil

local AllModifiers = {
    "HiddenEnemies", "Glass", "ExplodingEnemies", "Limitation", 
    "Committed", "HealthyEnemies", "Fog", "FlyingEnemies", 
    "Broke", "SpeedyEnemies", "Quarantine", "JailedTowers", "Inflation"
}

local DefaultSettings = {
    PathVisuals = false, MilitaryPath = false, MercenaryPath = false,
    AutoSkip = false, AutoChain = false, SupportCaravan = false, AutoDJ = false,
    AutoNecro = false, AutoRejoin = true, TimeScaleEnabled = false, TimeScaleValue = 2,
    SellFarms = false, AutoMercenary = false, AutoMilitary = false, AntiLag = false, Disable3DRendering = false,
    SendWebhook = false, SellFarmsWave = 1, WebhookURL = "", 
    StreamerMode = false, HideUsername = false, StreamerName = "", tagName = "None", 
    Modifiers = {}, EnemyTracker = false, AutoGatling = false
}

local TimeScaleValues = {0.5, 1, 1.5, 2}
local function NormalizeTimeScaleValue(val)
    val = tonumber(val)
    if not val then return nil end
    for _, v in ipairs(TimeScaleValues) do if v == val then return v end end
    return nil
end

local function CoerceTimeScaleValue(val, fallback)
    return NormalizeTimeScaleValue(val) or fallback
end

local function GetTimescaleFrame()
    local hotbar = PlayerGui:FindFirstChild("ReactUniversalHotbar")
    local frame = hotbar and hotbar:FindFirstChild("Frame")
    return frame and frame:FindFirstChild("timescale")
end

local StartTimeScale, ApplyTimeScaleOnce

local ItemNames = {
    ["17447507910"] = "Timescale Ticket(s)", ["17438486690"] = "Range Flag(s)",
    ["17438486138"] = "Damage Flag(s)", ["17438487774"] = "Cooldown Flag(s)",
    ["17429537022"] = "Blizzard(s)", ["17448596749"] = "Napalm Strike(s)",
    ["18493073533"] = "Spin Ticket(s)", ["17429548305"] = "Supply Drop(s)",
    ["18443277308"] = "Low Grade Consumable Crate(s)", ["136180382135048"] = "Santa Radio(s)",
    ["18443277106"] = "Mid Grade Consumable Crate(s)", ["18443277591"] = "High Grade Consumable Crate(s)",
    ["132155797622156"] = "Christmas Tree(s)", ["124065875200929"] = "Fruit Cake(s)",
    ["17429541513"] = "Barricade(s)", ["110415073436604"] = "Holy Hand Grenade(s)",
    ["17429533728"] = "Frag Grenade(s)", ["17437703262"] = "Molotov(s)",
    ["139414922355803"] = "Present Clusters(s)"
}

TDS = {
    PlacedTowers = {},
    ActiveStrat = true,
    MatchmakingMap = {
        ["Hardcore"] = "hardcore", ["Pizza Party"] = "halloween",
        ["Badlands"] = "badlands", ["Polluted"] = "polluted"
    }
}
TDS["placed_towers"] = TDS.PlacedTowers
TDS["active_strat"] = TDS.ActiveStrat
TDS["matchmaking_map"] = TDS.MatchmakingMap
local UpgradeHistory = {}
shared.TDSTable = TDS
shared["TDS_Table"] = TDS

local function SaveSettings()
    local DataToSave = {}
    for key, _ in pairs(DefaultSettings) do DataToSave[key] = Globals[key] end
    writefile(FileName, HttpService:JSONEncode(DataToSave))
end

local function LoadSettings()
    if isfile(FileName) then
        local success, data = pcall(function() return HttpService:JSONDecode(readfile(FileName)) end)
        if success and type(data) == "table" then
            for key, DefaultVal in pairs(DefaultSettings) do
                if data[key] ~= nil then Globals[key] = data[key] else Globals[key] = DefaultVal end
            end
            return
        end
    end
    for key, value in pairs(DefaultSettings) do Globals[key] = value end
    SaveSettings()
end

local function SetSetting(name, value)
    if DefaultSettings[name] ~= nil then
        if name == "TimeScaleValue" then value = CoerceTimeScaleValue(value, Globals.TimeScaleValue or 2) end
        Globals[name] = value
        SaveSettings()
    end
end

local function Apply3dRendering()
    if Globals.Disable3DRendering then
        game:GetService("RunService"):Set3dRenderingEnabled(false)
    else
        RunService:Set3dRenderingEnabled(true)
    end
    
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local gui = PlayerGui and PlayerGui:FindFirstChild("ADS_BlackScreen")
    
    if Globals.Disable3DRendering then
        if PlayerGui and not gui then
            gui = Instance.new("ScreenGui")
            gui.Name = "ADS_BlackScreen"
            gui.IgnoreGuiInset = true
            gui.ResetOnSpawn = false
            gui.DisplayOrder = -1000
            gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            gui.Parent = PlayerGui
            
            local frame = Instance.new("Frame")
            frame.Name = "Cover"
            frame.BackgroundColor3 = Color3.new(0, 0, 0)
            frame.BorderSizePixel = 0
            frame.Size = UDim2.fromScale(1, 1)
            frame.ZIndex = 0
            frame.Parent = gui
        end
        gui.Enabled = true
    else
        if gui then gui.Enabled = false end
    end
end

LoadSettings()
Globals.TimeScaleValue = CoerceTimeScaleValue(Globals.TimeScaleValue, 2)
Apply3dRendering()

-- ==========================================
-- // Tag Changer / Spoofing Logic
-- ==========================================
local isTagChangerRunning = false
local tagChangerConn = nil
local tagChangerTag = nil
local tagChangerOrig = nil

local function collectTagOptions()
    local list = {}
    local seen = {}
    local function addFolder(folder)
        if not folder then return end
        for _, child in ipairs(folder:GetChildren()) do
            local childName = child.Name
            if childName and not seen[childName] then
                seen[childName] = true
                list[#list + 1] = childName
            end
        end
    end
    local content = ReplicatedStorage:FindFirstChild("Content")
    if content then
        local nametag = content:FindFirstChild("Nametag")
        if nametag then
            addFolder(nametag:FindFirstChild("Basic"))
            addFolder(nametag:FindFirstChild("Exclusive"))
        end
    end
    table.sort(list)
    table.insert(list, 1, "None")
    return list
end

local function stopTagChanger()
    if tagChangerConn then
        tagChangerConn:Disconnect()
        tagChangerConn = nil
    end
    if tagChangerTag and tagChangerTag.Parent and tagChangerOrig ~= nil then
        pcall(function() tagChangerTag.Value = tagChangerOrig end)
    end
    tagChangerTag = nil
    tagChangerOrig = nil
end

local function startTagChanger()
    if isTagChangerRunning then return end
    isTagChangerRunning = true
    task.spawn(function()
        while Globals.tagName and Globals.tagName ~= "" and Globals.tagName ~= "None" do
            local tag = LocalPlayer:FindFirstChild("Tag")
            if tag then
                if tagChangerTag ~= tag then
                    if tagChangerConn then
                        tagChangerConn:Disconnect()
                        tagChangerConn = nil
                    end
                    tagChangerTag = tag
                    if tagChangerOrig == nil then tagChangerOrig = tag.Value end
                end
                if tag.Value ~= Globals.tagName then tag.Value = Globals.tagName end
                if not tagChangerConn then
                    tagChangerConn = tag:GetPropertyChangedSignal("Value"):Connect(function()
                        if Globals.tagName and Globals.tagName ~= "" and Globals.tagName ~= "None" then
                            if tag.Value ~= Globals.tagName then tag.Value = Globals.tagName end
                        end
                    end)
                end
            end
            task.wait(0.5)
        end
        isTagChangerRunning = false
    end)
end

if Globals.tagName and Globals.tagName ~= "" and Globals.tagName ~= "None" then
    startTagChanger()
end

local OriginalDisplayName = LocalPlayer.DisplayName
local OriginalUserName = LocalPlayer.Name

local SpoofTextCache = setmetatable({}, {__mode = "k"})
local PrivacyRunning = false
local LastSpoofName = nil
local PrivacyConns = {}
local PrivacyTextNodes = setmetatable({}, {__mode = "k"})
local StreamerTag = nil
local StreamerTagOrig = nil
local StreamerTagConn = nil

local function AddPrivacyConn(conn)
    if conn then PrivacyConns[#PrivacyConns + 1] = conn end
end

local function ClearPrivacyConns()
    for _, c in ipairs(PrivacyConns) do pcall(function() c:Disconnect() end) end
    PrivacyConns = {}
    for inst in pairs(PrivacyTextNodes) do PrivacyTextNodes[inst] = nil end
end

local function MakeSpoofName() return "BelowNatural" end

local function EnsureSpoofName()
    local nm = Globals.StreamerName
    if not nm or nm == "" then
        nm = MakeSpoofName()
        SetSetting("StreamerName", nm)
    end
    return nm
end

local function IsTagChangerActive()
    return Globals.tagName and Globals.tagName ~= "" and Globals.tagName ~= "None"
end

local function SetLocalDisplayName(nm)
    if not nm or nm == "" then return end
    pcall(function() LocalPlayer.DisplayName = nm end)
end

local function ReplacePlain(str, old, new)
    if not str or str == "" or not old or old == "" or old == new then return str, false end
    local start = 1
    local out = {}
    local changed = false
    while true do
        local i, j = string.find(str, old, start, true)
        if not i then
            out[#out + 1] = string.sub(str, start)
            break
        end
        changed = true
        out[#out + 1] = string.sub(str, start, i - 1)
        out[#out + 1] = new
        start = j + 1
    end
    if changed then return table.concat(out), true end
    return str, false
end

local function ApplySpoofToInstance(inst, OldA, OldB, NewName)
    if not inst then return end
    if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
        local txt = inst.Text
        if type(txt) == "string" and txt ~= "" then
            local HasA = OldA and OldA ~= "" and string.find(txt, OldA, 1, true)
            local HasB = OldB and OldB ~= "" and string.find(txt, OldB, 1, true)
            if not HasA and not HasB then return end
            
            local t = txt
            local changed = false
            local ch
            
            if OldA and OldA ~= "" then
                t, ch = ReplacePlain(t, OldA, NewName)
                if ch then changed = true end
            end
            if OldB and OldB ~= "" then
                t, ch = ReplacePlain(t, OldB, NewName)
                if ch then changed = true end
            end
            
            if changed then
                if SpoofTextCache[inst] == nil then SpoofTextCache[inst] = txt end
                inst.Text = t
            end
        end
    end
end

local function RestoreSpoofText()
    for inst, txt in pairs(SpoofTextCache) do
        if inst and inst.Parent then pcall(function() inst.Text = txt end) end
        SpoofTextCache[inst] = nil
    end
end

local function GetPrivacyName()
    if Globals.StreamerMode then return EnsureSpoofName() end
    if Globals.HideUsername then return "████████" end
    return nil
end

local function AddPrivacyNode(inst)
    if not (inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox")) then return end
    PrivacyTextNodes[inst] = true
    local nm = GetPrivacyName()
    if nm then ApplySpoofToInstance(inst, OriginalDisplayName, OriginalUserName, nm) end
end

local function HookPrivacyRoot(root)
    if not root then return end
    for _, inst in ipairs(root:GetDescendants()) do AddPrivacyNode(inst) end
    AddPrivacyConn(root.DescendantAdded:Connect(function(inst)
        if GetPrivacyName() then AddPrivacyNode(inst) end
    end))
end

local function SweepPrivacyText(nm)
    for inst in pairs(PrivacyTextNodes) do
        if inst and inst.Parent then
            ApplySpoofToInstance(inst, OriginalDisplayName, OriginalUserName, nm)
        else
            PrivacyTextNodes[inst] = nil
        end
    end
end

local function ApplyStreamerTag()
    if IsTagChangerActive() then
        if StreamerTagConn then StreamerTagConn:Disconnect(); StreamerTagConn = nil end
        StreamerTag = nil
        StreamerTagOrig = nil
        return
    end
    
    local nm = EnsureSpoofName()
    local tag = LocalPlayer:FindFirstChild("Tag")
    if not tag then return end
    
    if StreamerTag and StreamerTag ~= tag then
        if StreamerTagConn then StreamerTagConn:Disconnect(); StreamerTagConn = nil end
    end
    if StreamerTag ~= tag then
        StreamerTag = tag
        StreamerTagOrig = tag.Value
    end
    if tag.Value ~= nm then tag.Value = nm end
    
    if StreamerTagConn then StreamerTagConn:Disconnect(); StreamerTagConn = nil end
    StreamerTagConn = tag:GetPropertyChangedSignal("Value"):Connect(function()
        if not Globals.StreamerMode then return end
        if IsTagChangerActive() then return end
        local nm2 = EnsureSpoofName()
        if tag.Value ~= nm2 then tag.Value = nm2 end
    end)
end

local function RestoreStreamerTag()
    if StreamerTagConn then StreamerTagConn:Disconnect(); StreamerTagConn = nil end
    if IsTagChangerActive() then
        StreamerTag = nil
        StreamerTagOrig = nil
        return
    end
    if StreamerTag and StreamerTag.Parent and StreamerTagOrig ~= nil then
        pcall(function() StreamerTag.Value = StreamerTagOrig end)
    end
    StreamerTag = nil
    StreamerTagOrig = nil
end

local function ApplyPrivacyOnce()
    local nm = GetPrivacyName()
    if not nm then return end
    if LastSpoofName and LastSpoofName ~= nm then RestoreSpoofText() end
    if Globals.StreamerMode then ApplyStreamerTag() else RestoreStreamerTag() end
    SetLocalDisplayName(nm)
    SweepPrivacyText(nm)
    LastSpoofName = nm
end

local function StopPrivacyMode()
    ClearPrivacyConns()
    RestoreSpoofText()
    LastSpoofName = nil
    RestoreStreamerTag()
    SetLocalDisplayName(OriginalDisplayName)
    PrivacyRunning = false
end

local function StartPrivacyMode()
    if PrivacyRunning then return end
    PrivacyRunning = true
    ClearPrivacyConns()
    ApplyPrivacyOnce()
    
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if pg then HookPrivacyRoot(pg) end
    
    local CoreGui = game:GetService("CoreGui")
    if CoreGui then HookPrivacyRoot(CoreGui) end
    
    local TagsRoot = workspace:FindFirstChild("Nametags")
    if TagsRoot then HookPrivacyRoot(TagsRoot) end
    
    local ch = LocalPlayer.Character
    if ch then HookPrivacyRoot(ch) end
    
    AddPrivacyConn(LocalPlayer.CharacterAdded:Connect(function(NewChar)
        if GetPrivacyName() then
            HookPrivacyRoot(NewChar)
            ApplyPrivacyOnce()
        end
    end))
    
    AddPrivacyConn(workspace.ChildAdded:Connect(function(inst)
        if GetPrivacyName() and inst.Name == "Nametags" then
            HookPrivacyRoot(inst)
            ApplyPrivacyOnce()
        end
    end))
    
    local function step()
        if not GetPrivacyName() then StopPrivacyMode() return end
        ApplyPrivacyOnce()
        task.delay(0.5, step)
    end
    task.defer(step)
end

local function UpdatePrivacyState()
    if GetPrivacyName() then
        if not PrivacyRunning then StartPrivacyMode() else ApplyPrivacyOnce() end
    else
        if PrivacyRunning then StopPrivacyMode() end
    end
end
UpdatePrivacyState()

-- ==========================================
-- // Pathing & Visuals
-- ==========================================
local function FindPath()
    local MapFolder = workspace:FindFirstChild("Map")
    if not MapFolder then return nil end
    local PathsFolder = MapFolder:FindFirstChild("Paths")
    if not PathsFolder then return nil end
    local PathFolder = PathsFolder:GetChildren()[1]
    if not PathFolder then return nil end

    local PathNodes = {}
    for _, node in ipairs(PathFolder:GetChildren()) do
        if node:IsA("BasePart") then table.insert(PathNodes, node) end
    end

    table.sort(PathNodes, function(a, b)
        local NumA = tonumber(a.Name:match("%d+"))
        local NumB = tonumber(b.Name:match("%d+"))
        if NumA and NumB then return NumA < NumB end
        return a.Name < b.Name
    end)
    return PathNodes
end

local function TotalLength(PathNodes)
    local TotalLength = 0
    for i = 1, #PathNodes - 1 do
        TotalLength = TotalLength + (PathNodes[i + 1].Position - PathNodes[i].Position).Magnitude
    end
    return TotalLength
end

local MercenarySlider, MilitarySlider, MaxLenght

local function CalcLength()
    local map = workspace:FindFirstChild("Map")
    if GameState == "GAME" and map then
        local PathNodes = FindPath()
        if PathNodes and #PathNodes > 0 then
            MaxPathDistance = TotalLength(PathNodes)
            if MercenarySlider then MercenarySlider:SetMax(MaxPathDistance) end
            if MilitarySlider then MilitarySlider:SetMax(MaxPathDistance) end
            if MaxLenght then MaxLenght = MaxPathDistance end
            return true
        end
    end
    return false
end

local function GetPointAtDistance(PathNodes, distance)
    if not PathNodes or #PathNodes < 2 then return nil end

    local CurrentDist = 0
    for i = 1, #PathNodes - 1 do
        local StartPos = PathNodes[i].Position
        local EndPos = PathNodes[i+1].Position
        local SegmentLen = (EndPos - StartPos).Magnitude

        if CurrentDist + SegmentLen >= distance then
            local remaining = distance - CurrentDist
            local direction = (EndPos - StartPos).Unit
            return StartPos + (direction * remaining)
        end
        CurrentDist = CurrentDist + SegmentLen
    end
    return PathNodes[#PathNodes].Position
end

local function UpdatePathVisuals()
    if not Globals.PathVisuals then
        if MilMarker then MilMarker:Destroy() MilMarker = nil end
        if MercMarker then MercMarker:Destroy() MercMarker = nil end
        return
    end

    local PathNodes = FindPath()
    if not PathNodes then return end

    if not MilMarker then
        MilMarker = Instance.new("Part")
        MilMarker.Name = "MilVisual"
        MilMarker.Shape = Enum.PartType.Cylinder
        MilMarker.Size = Vector3.new(0.3, 3, 3)
        MilMarker.Color = Color3.fromRGB(0, 255, 0)
        MilMarker.Material = Enum.Material.Plastic
        MilMarker.Anchored = true
        MilMarker.CanCollide = false
        MilMarker.Orientation = Vector3.new(0, 0, 90)
        MilMarker.Parent = workspace
    end

    if not MercMarker then
        MercMarker = MilMarker:Clone()
        MercMarker.Name = "MercVisual"
        MercMarker.Color = Color3.fromRGB(255, 0, 0)
        MercMarker.Parent = workspace
    end

    local MilPos = GetPointAtDistance(PathNodes, Globals.MilitaryPath or 0)
    local MercPos = GetPointAtDistance(PathNodes, Globals.MercenaryPath or 0)

    if MilPos then
        MilMarker.Position = MilPos + Vector3.new(0, 0.2, 0)
        MilMarker.Transparency = 0.7
    end
    if MercPos then
        MercMarker.Position = MercPos + Vector3.new(0, 0.2, 0)
        MercMarker.Transparency = 0.7
    end
end

-- === NATIVE EQUIP AND UNEQUIP ===
function TDS:Equip(tower_name)
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction")
    local success, err = pcall(function() return remote:InvokeServer("Inventory", "Equip", "tower", tower_name) end)
    return success
end

function TDS:Unequip(tower_name)
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction")
    local success, err = pcall(function() return remote:InvokeServer("Inventory", "Unequip", "tower", tower_name) end)
    return success
end

local function GetEquippedTowers()
    local towers = {}
    local StateReplicators = ReplicatedStorage:FindFirstChild("StateReplicators")
    if StateReplicators then
        for _, folder in ipairs(StateReplicators:GetChildren()) do
            if folder.Name == "PlayerReplicator" and folder:GetAttribute("UserId") == LocalPlayer.UserId then
                local equipped = folder:GetAttribute("EquippedTowers")
                if type(equipped) == "string" then
                    local CleanedJson = equipped:match("%[.*%]") 
                    local success, TowerTable = pcall(function() return HttpService:JSONDecode(CleanedJson) end)
                    if success and type(TowerTable) == "table" then
                        for i = 1, 5 do
                            if TowerTable[i] then table.insert(towers, TowerTable[i]) end
                        end
                    end
                end
            end
        end
    end
    return #towers > 0 and towers or {"None"}
end

CurrentEquippedTowers = GetEquippedTowers()

-- ==========================================
-- // UI CREATION
-- ==========================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Sources/UI.lua"))()

local Window = Library:Window({
    Title = "Aether Hub",
    Desc = "your #1 hub (Premium Unlocked)",
    Theme = "Dark",
    DiscordLink = "https://discord.gg/autostrat",
    Icon = 126403638319957,
    Config = { Keybind = Enum.KeyCode.LeftControl, Size = UDim2.new(0, 500, 0, 400) }
})

local Autostrat = Window:Tab({Title = "Autostrat", Icon = "star"}) do
    Autostrat:Section({Title = "Main"})

    Autostrat:Toggle({
        Title = "Auto Rejoin",
        Desc = "Rejoins the gamemode after you've won and does the strategy again.",
        Value = Globals.AutoRejoin,
        Callback = function(v) SetSetting("AutoRejoin", v) end
    })

    Autostrat:Toggle({
        Title = "Auto Skip Waves",
        Desc = "Skips all Waves",
        Value = Globals.AutoSkip,
        Callback = function(v) SetSetting("AutoSkip", v) end
    })

    Autostrat:Toggle({
        Title = "Auto Chain",
        Desc = "Chains Commander Ability",
        Value = Globals.AutoChain,
        Callback = function(v) SetSetting("AutoChain", v) end
    })

    Autostrat:Toggle({
        Title = "Support Caravan",
        Desc = "Uses Commander Support Caravan",
        Value = Globals.SupportCaravan,
        Callback = function(v) SetSetting("SupportCaravan", v) end
    })

    Autostrat:Toggle({
        Title = "Auto DJ Booth",
        Desc = "Uses DJ Booth Ability",
        Value = Globals.AutoDJ,
        Callback = function(v) SetSetting("AutoDJ", v) end
    })

    Autostrat:Toggle({
        Title = "Auto Necro",
        Desc = "Uses Necromancer Ability",
        Value = Globals.AutoNecro,
        Callback = function(v) SetSetting("AutoNecro", v) end
    })

    Autostrat:Section({Title = "TimeScale"})
    Autostrat:Toggle({
        Title = "Enable TimeScale",
        Desc = "Unlocks and sets game speed using tickets",
        Value = Globals.TimeScaleEnabled,
        Callback = function(v)
            SetSetting("TimeScaleEnabled", v)
            if v then StartTimeScale() end
        end
    })

    Autostrat:Dropdown({
        Title = "TimeScale Speed",
        Desc = "Choose: 0.5, 1, 1.5, 2",
        List = {"0.5", "1", "1.5", "2"},
        Value = tostring(Globals.TimeScaleValue or 2),
        Callback = function(choice)
            local selected = type(choice) == "table" and choice[1] or choice
            local value = CoerceTimeScaleValue(selected, Globals.TimeScaleValue or 2)
            SetSetting("TimeScaleValue", value)
            if Globals.TimeScaleEnabled then ApplyTimeScaleOnce() end
        end
    })

    Autostrat:Dropdown({
        Title = "Modifiers:",
        List = AllModifiers,
        Value = Globals.Modifiers,
        Multi = true,
        Callback = function(choice) SetSetting("Modifiers", choice) end
    })

    Autostrat:Section({Title = "Farm"})
    Autostrat:Toggle({
        Title = "Sell Farms",
        Desc = "Sells all your farms on the specified wave",
        Value = Globals.SellFarms,
        Callback = function(v) SetSetting("SellFarms", v) end
    })

    Autostrat:Textbox({
        Title = "Wave:",
        Desc = "Wave to sell farms",
        Placeholder = "40",
        Value = tostring(Globals.SellFarmsWave),
        ClearTextOnFocus = false,
        Callback = function(text)
            local number = tonumber(text)
            if number then
                SetSetting("SellFarmsWave", number)
            else
                Window:Notify({ Title = "ADS", Desc = "Invalid number entered!", Time = 3, Type = "error" })
            end
        end
    })

    Autostrat:Section({Title = "Abilities"})
    Autostrat:Toggle({
        Title = "Auto Gatling Gun (Aimbot)",
        Desc = "Otomatis Aim, Tembak, dan Reload Gatling Gun tanpa masuk ke FPS mode.",
        Value = Globals.AutoGatling,
        Callback = function(v) SetSetting("AutoGatling", v) end
    })
    Autostrat:Toggle({
        Title = "Enable Path Distance Marker",
        Desc = "Red = Mercenary Base, Green = Military Base",
        Value = Globals.PathVisuals,
        Callback = function(v) SetSetting("PathVisuals", v) end
    })

    Autostrat:Toggle({
        Title = "Auto Mercenary Base",
        Desc = "Uses Air-Drop Ability",
        Value = Globals.AutoMercenary,
        Callback = function(v) SetSetting("AutoMercenary", v) end
    })

    MercenarySlider = Autostrat:Slider({
        Title = "Path Distance",
        Min = 0, Max = 300, Rounding = 0,
        Value = Globals.MercenaryPath,
        Callback = function(val) SetSetting("MercenaryPath", val) end
    })

    Autostrat:Toggle({
        Title = "Auto Military Base",
        Desc = "Uses Airstrike Ability",
        Value = Globals.AutoMilitary,
        Callback = function(v) SetSetting("AutoMilitary", v) end
    })

    MilitarySlider = Autostrat:Slider({
        Title = "Path Distance",
        Min = 0, Max = 300, Rounding = 0,
        Value = Globals.MilitaryPath,
        Callback = function(val) SetSetting("MilitaryPath", val) end
    })

    task.spawn(function()
        while true do
            local success = CalcLength()
            if success then break end 
            task.wait(3)
        end
    end)
end

Window:Line()

local Main = Window:Tab({Title = "Main", Icon = "stamp"}) do
    Main:Section({Title = "Tower Options"})
    
    local TowerDropdown = Main:Dropdown({
        Title = "Tower:",
        List = CurrentEquippedTowers,
        Value = CurrentEquippedTowers[1],
        Callback = function(choice) SelectedTower = choice end
    })

    local function RefreshDropdown()
        local NewTowers = GetEquippedTowers()
        if table.concat(NewTowers, ",") ~= table.concat(CurrentEquippedTowers, ",") then
            TowerDropdown:Clear() 
            for _, TowerName in ipairs(NewTowers) do
                TowerDropdown:Add(TowerName)
            end
            CurrentEquippedTowers = NewTowers
        end
    end

    task.spawn(function()
        while task.wait(2) do RefreshDropdown() end
    end)

    Main:Toggle({
        Title = "Stack Tower",
        Desc = "Enables Stacking placement",
        Value = false,
        Callback = function(v)
            StackEnabled = v
            if StackEnabled then
                Window:Notify({ Title = "ADS", Desc = "Make sure not to equip the tower, only select it and then place where you want to!", Time = 5, Type = "normal" })
            end
        end
    })

    Main:Button({
        Title = "Upgrade Selected",
        Callback = function()
            if SelectedTower then
                local TowersFolder = workspace:FindFirstChild("Towers")
                if TowersFolder then
                    for _, v in ipairs(TowersFolder:GetChildren()) do
                        local rep = v:FindFirstChild("TowerReplicator")
                        if rep and rep:GetAttribute("Name") == SelectedTower and rep:GetAttribute("OwnerId") == LocalPlayer.UserId then
                            RemoteFunc:InvokeServer("Troops", "Upgrade", "Set", {Troop = v})
                        end
                    end
                end
                Window:Notify({ Title = "ADS", Desc = "Attempted to upgrade all the selected towers!", Time = 3, Type = "normal" })
            end
        end
    })

    Main:Button({
        Title = "Sell Selected",
        Callback = function()
            if SelectedTower then
                local TowersFolder = workspace:FindFirstChild("Towers")
                if TowersFolder then
                    for _, v in ipairs(TowersFolder:GetChildren()) do
                        local rep = v:FindFirstChild("TowerReplicator")
                        if rep and rep:GetAttribute("Name") == SelectedTower and rep:GetAttribute("OwnerId") == LocalPlayer.UserId then
                            RemoteFunc:InvokeServer("Troops", "Sell", {Troop = v})
                        end
                    end
                end
                Window:Notify({ Title = "ADS", Desc = "Attempted to sell all the selected towers!", Time = 3, Type = "normal" })
            end
        end
    })

    Main:Button({
        Title = "Upgrade All",
        Callback = function()
            local TowersFolder = workspace:FindFirstChild("Towers")
            if TowersFolder then
                for _, v in ipairs(TowersFolder:GetChildren()) do
                    local owner = v:FindFirstChild("Owner")
                    if owner and owner.Value == LocalPlayer.UserId then
                        RemoteFunc:InvokeServer("Troops", "Upgrade", "Set", {Troop = v})
                    end
                end
            end
            Window:Notify({ Title = "ADS", Desc = "Attempted to upgrade all the towers!", Time = 3, Type = "normal" })
        end
    })

    Main:Button({
        Title = "Sell All",
        Callback = function()
            Window:Dialog({
                Title = "Do you want to sell all the towers?",
                Button1 = {
                    Title = "Confirm", Color = Color3.fromRGB(226, 39, 6),
                    Callback = function()
                        local TowersFolder = workspace:FindFirstChild("Towers")
                        if TowersFolder then
                            for _, v in ipairs(TowersFolder:GetChildren()) do
                                local owner = v:FindFirstChild("Owner")
                                if owner and owner.Value == LocalPlayer.UserId then
                                    RemoteFunc:InvokeServer("Troops", "Sell", {Troop = v})
                                end
                            end
                        end
                        Window:Notify({ Title = "ADS", Desc = "Attempted to sell all the towers!", Time = 3, Type = "normal" })
                    end
                },
                Button2 = { Title = "Cancel", Color = Color3.fromRGB(0, 188, 0) }
            })
        end
    })

    Main:Section({Title = "Equipper"})
    
    Main:Textbox({
        Title = "Equip:", Placeholder = "E.g. Gatling Gun", Value = "", ClearTextOnFocus = false,
        Callback = function(text)
            if text == "" or text == nil then return end
            task.spawn(function()
                local real_tower_name = ResolveTowerName(text)
                if not real_tower_name then
                    Window:Notify({ Title = "ADS", Desc = "Tower not found: " .. tostring(text), Time = 3, Type = "error" })
                    return
                end
                local success = TDS:Equip(real_tower_name)
                if success then
                    Window:Notify({ Title = "ADS", Desc = "Successfully equipped: " .. real_tower_name, Time = 3, Type = "normal" })
                else
                    Window:Notify({ Title = "ADS", Desc = "Failed to equip: " .. real_tower_name, Time = 3, Type = "error" })
                end
            end)
        end
    })

    Main:Textbox({
        Title = "Unequip:", Placeholder = "E.g. Farm", Value = "", ClearTextOnFocus = false,
        Callback = function(text)
            if text == "" or text == nil then return end
            task.spawn(function()
                local real_tower_name = ResolveTowerName(text)
                if not real_tower_name then
                    Window:Notify({ Title = "ADS", Desc = "Tower not found: " .. tostring(text), Time = 3, Type = "error" })
                    return
                end
                local success = TDS:Unequip(real_tower_name)
                if success then
                    Window:Notify({ Title = "ADS", Desc = "Successfully unequipped: " .. real_tower_name, Time = 3, Type = "normal" })
                else
                    Window:Notify({ Title = "ADS", Desc = "Failed to unequip: " .. real_tower_name, Time = 3, Type = "error" })
                end
            end)
        end
    })

    Main:Section({Title = "Skins"})
    
    local tower_skin_list = {}
    for t_name, _ in pairs(TowerSkins) do table.insert(tower_skin_list, t_name) end
    table.sort(tower_skin_list)

    local selected_skin_tower = tower_skin_list[1]
    local selected_skin_name = "Default"

    local function get_skins(tower)
        local list = {}
        if TowerSkins[tower] then
            for _, s_name in ipairs(TowerSkins[tower]) do table.insert(list, s_name) end
            table.sort(list)
        end
        return list
    end

    local SkinDropdown

    Main:Dropdown({
        Title = "Select Tower:", List = tower_skin_list, Value = selected_skin_tower,
        Callback = function(choice)
            selected_skin_tower = choice
            local new_skins = get_skins(choice)
            selected_skin_name = new_skins[1] or "Default"
            if SkinDropdown then
                SkinDropdown:Clear()
                for _, s in ipairs(new_skins) do SkinDropdown:Add(s) end
                SkinDropdown:SetValue(selected_skin_name)
            end
        end
    })

    SkinDropdown = Main:Dropdown({
        Title = "Select Skin:", List = get_skins(selected_skin_tower), Value = selected_skin_name,
        Callback = function(choice) selected_skin_name = choice end
    })

    Main:Button({
        Title = "Apply Skin",
        Callback = function()
            if selected_skin_tower and selected_skin_name then
                local success = pcall(function()
                    return game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer("Inventory", "Equip", "Skin", selected_skin_tower, selected_skin_name)
                end)
                if success then
                    Window:Notify({ Title = "ADS", Desc = "Successfully equipped " .. selected_skin_name .. " skin for " .. selected_skin_tower .. "!", Time = 3, Type = "normal" })
                else
                    Window:Notify({ Title = "ADS", Desc = "Failed to equip skin.", Time = 3, Type = "error" })
                end
            end
        end
    })

    Main:Section({Title = "Stats"})
    local CoinsLabel = Main:Label({Title = "Coins: 0", Desc = ""})
    local GemsLabel = Main:Label({Title = "Gems: 0", Desc = ""})
    local LevelLabel = Main:Label({Title = "Level: 0", Desc = ""})
    local WinsLabel = Main:Label({Title = "Wins: 0", Desc = ""})
    local LosesLabel = Main:Label({Title = "Loses: 0", Desc = ""})
    local ExpLabel = Main:Label({Title = "Experience: 0 / 0", Desc = ""})
    local ExpSlider = Main:Slider({ Title = "EXP", Desc = "", Min = 0, Max = 100, Rounding = 0, Value = 0, Callback = function() end })

    local function ParseNumber(val)
        if type(val) == "number" then return val end
        if type(val) == "string" then return tonumber((string.gsub(val, ",", ""))) end
        if type(val) == "table" and val.get then
            local ok, v = pcall(function() return val:get() end)
            if ok then return ParseNumber(v) end
        end
        return nil
    end

    local function ReadValue(obj)
        if not obj then return nil end
        local ok, v = pcall(function() return obj.Value end)
        if ok then return ParseNumber(v) end
        return nil
    end

    local function GetStatNumber(name)
        local obj = LocalPlayer:FindFirstChild(name)
        local v = ReadValue(obj)
        if v ~= nil then return v end
        v = ParseNumber(LocalPlayer:GetAttribute(name))
        if v ~= nil then return v end
        return nil
    end

    local function PickExpMax()
        local ExpObj = LocalPlayer:FindFirstChild("Experience")
        return (ExpObj and ParseNumber(ExpObj:GetAttribute("Max"))) or (ExpObj and ParseNumber(ExpObj:GetAttribute("Required"))) or (ExpObj and ParseNumber(ExpObj:GetAttribute("Next"))) or GetStatNumber("ExperienceMax") or GetStatNumber("ExperienceNeeded") or GetStatNumber("ExperienceRequired") or GetStatNumber("NextLevelExp") or GetStatNumber("MaxExperience") or 100
    end

    local GcExpCache = { t = nil, last = 0 }
    local function GetGcExp()
        if not getgc then return nil end
        local t = GcExpCache.t
        if t then
            local exp = ParseNumber(rawget(t, "exp") or rawget(t, "Exp") or rawget(t, "experience"))
            local MaxExp = ParseNumber(rawget(t, "maxExp") or rawget(t, "MaxExp") or rawget(t, "maxExperience"))
            local lvl = ParseNumber(rawget(t, "level") or rawget(t, "Level") or rawget(t, "lvl"))
            if exp and MaxExp then return exp, MaxExp, lvl end
        end
        local now = os.clock()
        if now - GcExpCache.last < 3 then return nil end
        GcExpCache.last = now
        local plvl = GetStatNumber("Level")
        
        for _, obj in ipairs(getgc(true)) do
            if type(obj) == "table" then
                local exp = ParseNumber(rawget(obj, "exp") or rawget(obj, "Exp") or rawget(obj, "experience"))
                local MaxExp = ParseNumber(rawget(obj, "maxExp") or rawget(obj, "MaxExp") or rawget(obj, "maxExperience"))
                if exp and MaxExp then
                    local lvl = ParseNumber(rawget(obj, "level") or rawget(obj, "Level"))
                    if not plvl or not lvl or lvl == plvl then
                        GcExpCache.t = obj
                        return exp, MaxExp, lvl
                    end
                end
            end
        end
        return nil
    end

    local function UpdateStats()
        local coins = GetStatNumber("Coins") or 0
        local gems = GetStatNumber("Gems") or 0
        local lvl = GetStatNumber("Level") or 0
        local wins = GetStatNumber("Triumphs") or 0
        local loses = GetStatNumber("Loses") or 0
        local exp = GetStatNumber("Experience") or 0
        local MaxExp = PickExpMax()
        local GcExp, GcMax, GcLvl = GetGcExp()
        
        if GcExp and GcMax then
            exp, MaxExp = GcExp, GcMax
            if GcLvl then lvl = GcLvl end
        end
        if MaxExp < 1 then MaxExp = 1 end
        if exp > MaxExp then MaxExp = exp end
        
        if CoinsLabel then CoinsLabel:SetTitle("Coins: " .. tostring(coins)) end
        if GemsLabel then GemsLabel:SetTitle("Gems: " .. tostring(gems)) end
        if LevelLabel then LevelLabel:SetTitle("Level: " .. tostring(lvl)) end
        if WinsLabel then WinsLabel:SetTitle("Wins: " .. tostring(wins)) end
        if LosesLabel then LosesLabel:SetTitle("Loses: " .. tostring(loses)) end
        if ExpLabel then ExpLabel:SetTitle("Experience: " .. tostring(exp) .. " / " .. tostring(MaxExp)) end
        if ExpSlider then ExpSlider:SetMin(0) ExpSlider:SetMax(MaxExp) ExpSlider:SetValue(exp) end
    end

    local StatsQueued = false
    local function QueueStatsUpdate()
        if StatsQueued then return end
        StatsQueued = true
        task.delay(0.2, function()
            StatsQueued = false
            UpdateStats()
        end)
    end

    local function HookStatObj(obj)
        if not obj then return end
        if obj.Changed then obj.Changed:Connect(QueueStatsUpdate) end
        obj:GetAttributeChangedSignal("Max"):Connect(QueueStatsUpdate)
        obj:GetAttributeChangedSignal("Required"):Connect(QueueStatsUpdate)
        obj:GetAttributeChangedSignal("Next"):Connect(QueueStatsUpdate)
    end

    local StatNames = {"Coins", "Gems", "Level", "Triumphs", "Loses", "Experience"}
    for _, name in ipairs(StatNames) do
        HookStatObj(LocalPlayer:FindFirstChild(name))
        LocalPlayer:GetAttributeChangedSignal(name):Connect(QueueStatsUpdate)
    end
    LocalPlayer.ChildAdded:Connect(function(child)
        if table.find(StatNames, child.Name) then HookStatObj(child) QueueStatsUpdate() end
    end)
    LocalPlayer.ChildRemoved:Connect(function(child)
        if table.find(StatNames, child.Name) then QueueStatsUpdate() end
    end)
    QueueStatsUpdate()
end

Window:Line()

local Misc = Window:Tab({Title = "Misc", Icon = "box"}) do
    Misc:Section({Title = "Misc"})
    Misc:Toggle({ Title = "Enable Anti-Lag", Desc = "Boosts your FPS", Value = Globals.AntiLag, Callback = function(v) SetSetting("AntiLag", v) end })
    Misc:Toggle({ Title = "Disable 3d rendering", Desc = "Turns off 3d rendering", Value = Globals.Disable3DRendering, Callback = function(v) SetSetting("Disable3DRendering", v) Apply3dRendering() end })

    -- // ==========================================
    -- // ADVANCED RADAR: UPCOMING WAVE ONLY
    -- // ==========================================
    local TrackerUI, TrackerConnection
    local CachedModeModule, CachedModeName
    local LastProcessedWave = -1

    local function GetModeDataModule()
        if CachedModeModule then return CachedModeModule, CachedModeName end
        
        local state = ReplicatedStorage:FindFirstChild("State") or workspace:FindFirstChild("State")
        if not state then return nil, "Waiting for State..." end

        local modeObj = state:FindFirstChild("Mode")
        local diffObj = state:FindFirstChild("Difficulty")

        local modeName = (modeObj and modeObj.Value ~= "") and modeObj.Value or nil
        local diffName = (diffObj and diffObj.Value ~= "") and diffObj.Value or nil

        if not modeName or not diffName then return nil, "None" end
        CachedModeName = diffName

        local content = ReplicatedStorage:FindFirstChild("Content")
        local gamemodes = content and content:FindFirstChild("Gamemodes")
        if not gamemodes then return nil, "Missing Gamemodes Folder" end

        local function cleanString(str) return str:lower():gsub("[%s%p]", "") end
        local safeMode, safeDiff = cleanString(modeName), cleanString(diffName)

        local mFolder = gamemodes:FindFirstChild(modeName)
        if mFolder then
            local diffsFolder = mFolder:FindFirstChild("Difficulties")
            if diffsFolder then
                local targetDiff = diffsFolder:FindFirstChild(diffName)
                if targetDiff and targetDiff:FindFirstChild("Waves") then
                    CachedModeModule = targetDiff.Waves
                    return CachedModeModule, CachedModeName
                end
            end
        end

        for _, mDir in ipairs(gamemodes:GetChildren()) do
            if cleanString(mDir.Name) == safeMode or string.find(cleanString(mDir.Name), safeMode) then
                local diffsDir = mDir:FindFirstChild("Difficulties")
                if diffsDir then
                    for _, dDir in ipairs(diffsDir:GetChildren()) do
                        if cleanString(dDir.Name) == safeDiff or string.find(cleanString(dDir.Name), safeDiff) then
                            if dDir:FindFirstChild("Waves") then
                                CachedModeModule = dDir.Waves
                                return CachedModeModule, CachedModeName .. " (Fuzzy)"
                            end
                        end
                    end
                end
            end
        end

        for _, folder in ipairs(gamemodes:GetDescendants()) do
            if folder:IsA("Folder") and cleanString(folder.Name) == safeDiff then
                if folder:FindFirstChild("Waves") then
                    CachedModeModule = folder.Waves
                    return CachedModeModule, CachedModeName .. " (Deep Scan)"
                end
            end
        end
        return nil, "Waves Not Found"
    end

    local function GetFastWave()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        local container = pg and pg:FindFirstChild("ReactGameTopGameDisplay") 
        local waveContainer = container and container:FindFirstChild("Frame") and container.Frame:FindFirstChild("wave")
        if waveContainer and waveContainer:FindFirstChild("container") then
            return tonumber(waveContainer.container.value.Text:match("^(%d+)")) or 0
        end
        return 0
    end

    local TDS_Modifiers = {
        ["1"] = "God", ["2"] = "Hidden", ["3"] = "Flying", ["4"] = "Stunned", 
        ["5"] = "Lead", ["6"] = "CliffUnit", ["7"] = "StunImmune", ["8"] = "Ignore", 
        ["9"] = "HiddenDetection", ["10"] = "Boss", ["11"] = "ExplosionImmune", 
        ["12"] = "EnergyImmune", ["13"] = "FreezeImmune", ["14"] = "FireImmune", 
        ["15"] = "Ghost", ["16"] = "Invincible", ["17"] = "HealthRegen", 
        ["18"] = "Slime", ["19"] = "Nimble", ["20"] = "Bloated", ["21"] = "LastSlime", 
        ["22"] = "Tank", ["23"] = "Explosive", ["24"] = "Jailed", ["25"] = "Aggro", 
        ["26"] = "DoubleDamage", ["27"] = "MoltenCorpse", ["28"] = "Frozen", 
        ["29"] = "FullRefund", ["30"] = "FireworkBuff", ["31"] = "Hologram", 
        ["32"] = "Blessed", ["33"] = "Shield", ["34"] = "SpeedBoost", ["35"] = "HiddenExposed"
    }

    local function ParseModifiers(modTable)
        if type(modTable) ~= "table" then return "" end
        local mods = {}
        for k, v in pairs(modTable) do
            if v then
                local strKey = tostring(k)
                if typeof(k) == "EnumItem" then strKey = tostring(k.Value)
                elseif type(k) == "table" and k.Value then strKey = tostring(k.Value)
                else strKey = tostring(k):match("%d+") or tostring(k) end
                
                local modName = TDS_Modifiers[strKey] or strKey
                if tonumber(strKey) == nil then modName = strKey end 
                table.insert(mods, modName)
            end
        end
        return #mods > 0 and " [" .. table.concat(mods, ", ") .. "]" or ""
    end

    local function CreateTrackerUI()
        -- Prevent overlapping UIs upon script re-execution
        local existingUI = game:GetService("CoreGui"):FindFirstChild("ADS_PremiumTracker")
        if existingUI then existingUI:Destroy() end

        LastProcessedWave, CachedModeModule = -1, nil
        
        TrackerUI = Instance.new("ScreenGui")
        TrackerUI.Name = "ADS_PremiumTracker"
        TrackerUI.ResetOnSpawn = false
        TrackerUI.Parent = game:GetService("CoreGui")

        local MainFrame = Instance.new("Frame", TrackerUI)
        MainFrame.Size = UDim2.new(0, 280, 0, 240) 
        MainFrame.Position = UDim2.new(1, -295, 0.5, -120)
        MainFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 22)
        MainFrame.BackgroundTransparency = 0.1
        Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
        
        local MainStroke = Instance.new("UIStroke", MainFrame)
        MainStroke.Color = Color3.fromRGB(60, 65, 80)
        MainStroke.Transparency = 0.3
        MainStroke.Thickness = 1

        local UpcomingTitle = Instance.new("TextLabel", MainFrame)
        UpcomingTitle.Size = UDim2.new(1, -24, 0, 24)
        UpcomingTitle.Position = UDim2.new(0, 12, 0, 8)
        UpcomingTitle.BackgroundTransparency = 1
        UpcomingTitle.Text = "🔮 UPCOMING WAVE"
        UpcomingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        UpcomingTitle.Font = Enum.Font.GothamBold
        UpcomingTitle.TextSize = 12
        UpcomingTitle.TextXAlignment = Enum.TextXAlignment.Left
        UpcomingTitle.RichText = true

        local EcoWidget = Instance.new("Frame", MainFrame)
        EcoWidget.Size = UDim2.new(1, -24, 0, 48)
        EcoWidget.Position = UDim2.new(0, 12, 0, 36)
        EcoWidget.BackgroundColor3 = Color3.fromRGB(22, 25, 35)
        EcoWidget.BackgroundTransparency = 0.4
        Instance.new("UICorner", EcoWidget).CornerRadius = UDim.new(0, 6)
        local EcoStroke = Instance.new("UIStroke", EcoWidget)
        EcoStroke.Color = Color3.fromRGB(50, 55, 70)
        
        local WaveInfoLabel = Instance.new("TextLabel", EcoWidget)
        WaveInfoLabel.Size = UDim2.new(1, -16, 1, -8)
        WaveInfoLabel.Position = UDim2.new(0, 8, 0, 4)
        WaveInfoLabel.BackgroundTransparency = 1
        WaveInfoLabel.Font = Enum.Font.GothamMedium
        WaveInfoLabel.TextSize = 11
        WaveInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
        WaveInfoLabel.TextYAlignment = Enum.TextYAlignment.Center
        WaveInfoLabel.RichText = true

        local UpcomingScroll = Instance.new("ScrollingFrame", MainFrame)
        UpcomingScroll.Size = UDim2.new(1, -14, 1, -100) 
        UpcomingScroll.Position = UDim2.new(0, 7, 0, 92)
        UpcomingScroll.BackgroundTransparency = 1
        UpcomingScroll.ScrollBarThickness = 2
        UpcomingScroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)
        UpcomingScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        UpcomingScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local UpcomingPadding = Instance.new("UIPadding", UpcomingScroll)
        UpcomingPadding.PaddingLeft = UDim.new(0, 5)
        UpcomingPadding.PaddingRight = UDim.new(0, 5)
        UpcomingPadding.PaddingBottom = UDim.new(0, 10)
        
        local UpcomingLayout = Instance.new("UIListLayout", UpcomingScroll)
        UpcomingLayout.Padding = UDim.new(0, 4)
        UpcomingLayout.SortOrder = Enum.SortOrder.LayoutOrder

        return UpcomingScroll, UpcomingTitle, WaveInfoLabel
    end

    local function CreateUpcomingEntry(parent, text, color)
        local EntryBg = Instance.new("Frame", parent)
        EntryBg.Size = UDim2.new(1, 0, 0, 22)
        EntryBg.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
        EntryBg.BackgroundTransparency = 0.5
        Instance.new("UICorner", EntryBg).CornerRadius = UDim.new(0, 4)
        
        local ColorStrip = Instance.new("Frame", EntryBg)
        ColorStrip.Size = UDim2.new(0, 3, 1, -8)
        ColorStrip.Position = UDim2.new(0, 4, 0, 4)
        ColorStrip.BackgroundColor3 = color
        ColorStrip.BorderSizePixel = 0
        Instance.new("UICorner", ColorStrip).CornerRadius = UDim.new(1, 0)

        local EntryTxt = Instance.new("TextLabel", EntryBg)
        EntryTxt.Size = UDim2.new(1, -16, 1, 0)
        EntryTxt.Position = UDim2.new(0, 12, 0, 0)
        EntryTxt.BackgroundTransparency = 1
        EntryTxt.Text = text
        EntryTxt.TextColor3 = Color3.fromRGB(230, 230, 235)
        EntryTxt.Font = Enum.Font.GothamMedium
        EntryTxt.TextSize = 11
        EntryTxt.TextXAlignment = Enum.TextXAlignment.Left
        EntryTxt.RichText = true
    end

    Misc:Toggle({
        Title = "Advanced Enemy Radar",
        Desc = "Displays Upcoming Waves only",
        Value = Globals.EnemyTracker or false,
        Callback = function(v)
            Globals.EnemyTracker = v
            SetSetting("EnemyTracker", v)

            if v then
                local UpcomingScroll, UpcomingTitle, WaveInfoLabel = CreateTrackerUI()
                
                if TrackerConnection then TrackerConnection:Disconnect() end
                
                TrackerConnection = RunService.Heartbeat:Connect(function()
                    if not Globals.EnemyTracker or not TrackerUI or not TrackerUI.Parent then 
                        if TrackerConnection then TrackerConnection:Disconnect() end
                        return 
                    end
                    
                    local currentWave = GetFastWave()
                    if currentWave ~= LastProcessedWave then
                        LastProcessedWave = currentWave
                        local nextWaveNum = currentWave + 1
                        UpcomingTitle.Text = string.format("🔮 UPCOMING WAVE <font color='#888899'>[%d]</font>", nextWaveNum)
                        
                        for _, child in ipairs(UpcomingScroll:GetChildren()) do 
                            if child:IsA("Frame") then child:Destroy() end 
                        end

                        local modeDataModule, stateDiffName = GetModeDataModule()
                        
                        if modeDataModule then
                            local success, modeData = pcall(function() return require(modeDataModule) end)
                            
                            if success and type(modeData) == "table" and modeData.Waves then
                                
                                local function GetWaveEconomy(targetWave)
                                    local wCash, cBonus = 0, 0
                                    if targetWave > 0 then
                                        pcall(function()
                                            if modeData.ExtraOptions and type(modeData.ExtraOptions.WaveCash) == "function" then
                                                wCash = modeData.ExtraOptions.WaveCash(targetWave)
                                            else
                                                wCash = 200 + ((targetWave - 1) * 160)
                                            end
                                            
                                            if modeData.ExtraOptions and modeData.ExtraOptions.ClearBonus then
                                                local playersCount = #game:GetService("Players"):GetPlayers()
                                                local bonusPct = modeData.ExtraOptions.ClearBonus.Percentage or 0.2
                                                
                                                if playersCount <= 1 and modeData.ExtraOptions.ClearBonus.SoloPercentage then
                                                    bonusPct = modeData.ExtraOptions.ClearBonus.SoloPercentage
                                                end
                                                cBonus = wCash * bonusPct
                                            end
                                        end)
                                    end
                                    return math.floor(wCash), math.floor(cBonus)
                                end

                                local currCash, currBonus = GetWaveEconomy(currentWave)
                                local nextCash, nextBonus = GetWaveEconomy(nextWaveNum)
                                
                                WaveInfoLabel.Text = string.format(
                                    "<font color='#AABBFF'>MODE:</font> <font color='#FFFFFF'>%s</font>\n" ..
                                    "<font color='#888899'>W-%02d |</font> <font color='#44FF44'>+$%d</font> <font color='#888899'>(+$%d Bonus)</font>\n" ..
                                    "<font color='#888899'>W-%02d |</font> <font color='#44FF44'>+$%d</font> <font color='#888899'>(+$%d Bonus)</font>", 
                                    stateDiffName:upper(), 
                                    currentWave, currCash, currBonus,
                                    nextWaveNum, nextCash, nextBonus
                                )

                                local nextWaveData = modeData.Waves[nextWaveNum]
                                if nextWaveData and nextWaveData.WaveTimeline and nextWaveData.WaveTimeline.Enemies then
                                    for _, enemy in ipairs(nextWaveData.WaveTimeline.Enemies) do
                                        local eMods = ParseModifiers(enemy.Modifiers)
                                        local stripColor = Color3.fromRGB(150, 150, 160)
                                        if eMods ~= "" then stripColor = Color3.fromRGB(255, 80, 80) end
                                        if enemy.Name:find("Boss") or enemy.Name:find("King") then stripColor = Color3.fromRGB(180, 80, 255) end
                                        
                                        local text = string.format("<b>x%d</b> <font color='#FFFFFF'>%s</font> <font face='Code' color='#777788'>(%.1fs)</font><font color='#FFBB55'>%s</font>", enemy.Amount or 1, enemy.Name or "Unknown", enemy.Delay or 0, eMods)
                                        CreateUpcomingEntry(UpcomingScroll, text, stripColor)
                                    end
                                else
                                    CreateUpcomingEntry(UpcomingScroll, "<i>No more wave data.</i>", Color3.fromRGB(100, 100, 110))
                                end
                            else
                                WaveInfoLabel.Text = "SYSTEM ERROR: FAILED TO PARSE MODULE"
                                CachedModeModule = nil 
                                CreateUpcomingEntry(UpcomingScroll, "Data corruption detected.", Color3.fromRGB(255, 50, 50))
                            end
                        else
                            WaveInfoLabel.Text = "MODE: " .. tostring(stateDiffName):upper()
                            CreateUpcomingEntry(UpcomingScroll, "Waiting for telemetry...", Color3.fromRGB(100, 100, 120))
                        end
                    end
                end)
            else
                if TrackerConnection then TrackerConnection:Disconnect() end
                if TrackerUI then TrackerUI:Destroy() end
            end
        end
    })

    Misc:Section({Title = "Experimental"})
    
    Misc:Toggle({
        Title = "Sticker Spam",
        Desc = "This will drop everyones FPS to like 5 (you will not be able to see this unless you have an alt)",
        Value = false,
        Callback = function(v)
            StickerSpam = v
            if StickerSpam then
                task.spawn(function()
                    while StickerSpam do
                        for i = 1, 9999 do
                            if not StickerSpam then break end
                            local args = {"Flex"}
                            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Sticker"):WaitForChild("URE:Show"):FireServer(unpack(args))
                        end
                        task.wait()
                    end
                end)
            end
        end
    })

    Misc:Toggle({
        Title = "Party Invite Spam (Lobby)",
        Desc = "Spam invites to everyone in the lobby (Warning: annoying!)",
        Value = false,
        Callback = function(state)
            Globals.PartySpamEnabled = state
            if state then
                if GameState ~= "LOBBY" then
                    Window:Notify({ Title = "Error", Desc = "You can only use this feature in the Lobby!", Time = 3, Type = "error" })
                    Globals.PartySpamEnabled = false
                    return
                end
                Window:Notify({Title = "ADS", Desc = "Party Spam Enabled!", Time = 3, Type = "normal"})
                task.spawn(function()
                    local plrs = game:GetService("Players")
                    local rfunc = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction")
                    while Globals.PartySpamEnabled do
                        pcall(function()
                            rfunc:InvokeServer("Party", "CreateParty")
                            for _, plr in ipairs(plrs:GetPlayers()) do
                                if plr ~= plrs.LocalPlayer then rfunc:InvokeServer("Party", "InvitePlayer", plr) end
                            end
                            rfunc:InvokeServer("Party", "LeaveParty")
                        end)
                        task.wait(0.2)
                    end
                end)
            end
        end
    })

    Misc:Button({
        Title = "Open Inventory",
        Desc = "Open Inventory",
        Callback = function()
            local RS = game:GetService("ReplicatedStorage")
            pcall(function()
                local NewNetwork = require(RS.Shared.Modules.NewNetwork)
                NewNetwork.Channel("Inventory"):fireUnreliableServer("OpenInventory")
            end)

            local foundStore = false
            for _, module in ipairs(getloadedmodules()) do
                if module.Name == "View" and module.Parent and module.Parent.Name == "Stores" then
                    local Store = require(module)
                    Store:commit("setView", "Inventory")
                    foundStore = true
                    print("Berhasil membuka UI Inventory secara paksa!")
                    break
                end
            end

            if not foundStore then
                warn("Gagal menemukan Module Store UI. Pastikan game sudah loading sepenuhnya.")
            end
        end
    })

    Misc:Button({
        Title = "Unlock Admin+ (Sandbox)",
        Desc = "Keep in mind that some features such as selecting maps, spawning in enemies and changing tower stats will not work!",
        Callback = function()
            if GameState == "GAME" then
                local args = { game.Players.LocalPlayer.UserId, true }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Sandbox"):WaitForChild("RE:SetAdmin"):FireServer(unpack(args))
                Window:Notify({ Title = "ADS", Desc = "Successfully unlocked Admin+ Mode!", Time = 3, Type = "normal" })
            else
                Window:Notify({ Title = "ADS", Desc = "You must be in Sandbox mode for this to work!", Time = 3, Type = "normal" })
            end
        end
    })
end

Window:Line()

local Logger = Window:Tab({Title = "Logger", Icon = "notebook-pen"}) do
    Logger = Logger:CreateLogger({
        Title = "STRATEGY LOGGER:",
        Size = UDim2.new(0, 330, 0, 300)
    })
end

Window:Line()

local RecorderInit = loadstring(game:HttpGet("https://raw.githubusercontent.com/Crytx-X/Crytx/refs/heads/main/Sources/Recorder.lua"))()
if type(RecorderInit) == "function" then
    RecorderInit({ Window = Window, ReplicatedStorage = ReplicatedStorage, LocalPlayer = LocalPlayer, HttpService = HttpService, GameState = GameState, workspace = workspace })
end

Window:Line()

local Settings = Window:Tab({Title = "Settings", Icon = "settings"}) do
    Settings:Section({Title = "Settings"})
    
    Settings:Button({
        Title = "Save Settings",
        Callback = function()
            Window:Notify({ Title = "ADS", Desc = "Settings Saved!", Time = 3, Type = "normal" })
            LoadSettings()
        end
    })

    Settings:Button({
        Title = "Load Settings",
        Callback = function()
            Window:Notify({ Title = "ADS", Desc = "Settings Loaded!", Time = 3, Type = "normal" })
            SaveSettings()
        end
    })

    Settings:Section({Title = "Privacy"})
    
    Settings:Toggle({
        Title = "Hide Username", Value = Globals.HideUsername,
        Callback = function(v) SetSetting("HideUsername", v) UpdatePrivacyState() end
    })

    Settings:Textbox({
        Title = "Streamer Name", Placeholder = "Spoof Name", Value = Globals.StreamerName or "", ClearTextOnFocus = false,
        Callback = function(value) SetSetting("StreamerName", value or "") UpdatePrivacyState() end
    })

    Settings:Toggle({
        Title = "Streamer Mode", Value = Globals.StreamerMode,
        Callback = function(v) SetSetting("StreamerMode", v) UpdatePrivacyState() end
    })

    Settings:Section({Title = "Tags"})
    
    local tagOptions = collectTagOptions()
    local tagValue = Globals.tagName or "None"
    if not table.find(tagOptions, tagValue) then tagValue = "None" end
    
    Settings:Dropdown({
        Title = "Tag Changer", List = tagOptions, Value = tagValue,
        Callback = function(choice)
            local selected = choice
            if type(choice) == "table" then selected = choice[1] end
            if not selected or selected == "" then selected = "None" end
            SetSetting("tagName", selected)
            if selected == "None" then stopTagChanger() else startTagChanger() end
        end
    })

    Settings:Section({Title = "Webhook"})
    
    Settings:Toggle({ Title = "Send Webhook", Value = Globals.SendWebhook, Callback = function(v) SetSetting("SendWebhook", v) end })

    Settings:Button({
        Title = "Test Webhook",
        Callback = function()
            if not Globals.WebhookURL or Globals.WebhookURL == "" then
                return Window:Notify({Title = "Error", Desc = "Webhook URL is empty!", Time = 3, Type = "error"})
            end
            local success, response = pcall(function()
                return SendRequest({
                    Url = Globals.WebhookURL, Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = game:GetService("HttpService"):JSONEncode({["content"] = "Webhook Test"})
                })
            end)
            if success and response.StatusCode >= 200 and response.StatusCode < 300 then
                Window:Notify({ Title = "ADS", Desc = "Webhook sent successfully and is working!", Time = 3, Type = "normal" })
            else
                Window:Notify({ Title = "Error", Desc = "Invalid Webhook, Discord returned an error.", Time = 5, Type = "error" })
            end
        end
    })

    Settings:Textbox({
        Title = "Webhook URL:", Placeholder = "https://discord.com/api/webhooks/...", Value = Globals.WebhookURL, ClearTextOnFocus = true,
        Callback = function(value)
            if value ~= "" and value:find("https://discord.com/api/webhooks/") then
                SetSetting("WebhookURL", value)
                Window:Notify({ Title = "ADS", Desc = "Webhook is successfully set!", Time = 3, Type = "normal" })
            else
                Window:Notify({ Title = "ADS", Desc = "Invalid Webhook URL!", Time = 3, Type = "normal" })
            end
        end
    })
end

-- // Game Interaction Loops
RunService.RenderStepped:Connect(function()
    if StackEnabled then
        if not StackSphere then
            StackSphere = Instance.new("Part")
            StackSphere.Shape = Enum.PartType.Ball
            StackSphere.Size = Vector3.new(1.5, 1.5, 1.5)
            StackSphere.Color = Color3.fromRGB(0, 255, 0)
            StackSphere.Transparency = 0.5
            StackSphere.Anchored = true
            StackSphere.CanCollide = false
            StackSphere.Material = Enum.Material.Neon
            StackSphere.Parent = workspace
            mouse.TargetFilter = StackSphere
        end
        local hit = mouse.Hit
        if hit then StackSphere.Position = hit.Position end
    elseif StackSphere then
        StackSphere:Destroy()
        StackSphere = nil
    end

    UpdatePathVisuals()
end)

mouse.Button1Down:Connect(function()
    if StackEnabled and StackSphere and SelectedTower then
        local pos = StackSphere.Position
        local newpos = Vector3.new(pos.X, pos.Y + 25, pos.Z)
        RemoteFunc:InvokeServer("Troops", "Pl\208\176ce", {Rotation = CFrame.new(), Position = newpos}, SelectedTower)
    end
end)

-- // currency tracking
local StartCoins, CurrentTotalCoins, StartGems, CurrentTotalGems = 0, 0, 0, 0
if GameState == "GAME" then
    pcall(function()
        repeat task.wait(1) until LocalPlayer:FindFirstChild("Coins")
        StartCoins = LocalPlayer.Coins.Value
        CurrentTotalCoins = StartCoins
        StartGems = LocalPlayer.Gems.Value
        CurrentTotalGems = StartGems
    end)
end

local function CheckResOk(data)
    if data == true then return true end
    if type(data) == "table" and data.Success == true then return true end
    local success, IsModel = pcall(function() return data and data:IsA("Model") end)
    if success and IsModel then return true end
    if type(data) == "userdata" then return true end
    return false
end

-- // Automation Helpers
local function GetAllRewards()
    local results = {
        Coins = 0, Gems = 0, XP = 0, Wave = 0, Level = 0,
        Time = "00:00", Status = "UNKNOWN", Others = {} 
    }

    local UiRoot = PlayerGui:FindFirstChild("ReactGameNewRewards")
    local MainFrame = UiRoot and UiRoot:FindFirstChild("Frame")
    local GameOver = MainFrame and MainFrame:FindFirstChild("gameOver")
    local RewardsScreen = GameOver and GameOver:FindFirstChild("RewardsScreen")

    local GameStats = RewardsScreen and RewardsScreen:FindFirstChild("gameStats")
    local StatsList = GameStats and GameStats:FindFirstChild("stats")

    if StatsList then
        for _, frame in ipairs(StatsList:GetChildren()) do
            local l1 = frame:FindFirstChild("textLabel")
            local l2 = frame:FindFirstChild("textLabel2")
            if l1 and l2 and l1.Text:find("Time Completed:") then
                results.Time = l2.Text
                break
            end
        end
    end

    local TopBanner = RewardsScreen and RewardsScreen:FindFirstChild("RewardBanner")
    if TopBanner and TopBanner:FindFirstChild("textLabel") then
        local txt = TopBanner.textLabel.Text:upper()
        results.Status = txt:find("TRIUMPH") and "WIN" or (txt:find("LOST") and "LOSS" or "UNKNOWN")
    end

    local LevelValue = LocalPlayer.Level
    if LevelValue then results.Level = LevelValue.Value or 0 end

    local label = PlayerGui:WaitForChild("ReactGameTopGameDisplay").Frame.wave.container.value
    local WaveNum = label.Text:match("^(%d+)")
    if WaveNum then results.Wave = tonumber(WaveNum) or 0 end

    local SectionRewards = RewardsScreen and RewardsScreen:FindFirstChild("RewardsSection")
    if SectionRewards then
        for _, item in ipairs(SectionRewards:GetChildren()) do
            if tonumber(item.Name) then 
                local IconId = "0"
                local img = item:FindFirstChildWhichIsA("ImageLabel", true)
                if img then IconId = img.Image:match("%d+") or "0" end

                for _, child in ipairs(item:GetDescendants()) do
                    if child:IsA("TextLabel") then
                        local text = child.Text
                        local amt = tonumber(text:match("(%d+)")) or 0

                        if text:find("Coins") then
                            results.Coins = amt
                        elseif text:find("Gems") then
                            results.Gems = amt
                        elseif text:find("XP") then
                            results.XP = amt
                        elseif text:lower():find("x%d+") then 
                            local displayName = ItemNames[IconId] or "Unknown Item (" .. IconId .. ")"
                            table.insert(results.Others, {Amount = text:match("x%d+"), Name = displayName})
                        end
                    end
                end
            end
        end
    end

    return results
end

local function RejoinMatch()
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction")
    local success = false
    local res

    repeat
        local StateFolder = ReplicatedStorage:FindFirstChild("State")
        local CurrentMode = StateFolder and StateFolder.Difficulty.Value

        if CurrentMode then
            local ok, result = pcall(function()
                local payload
                if CurrentMode == "PizzaParty" then payload = { mode = "halloween", count = 1 }
                elseif CurrentMode == "Hardcore" then payload = { mode = "hardcore", count = 1 }
                elseif CurrentMode == "PollutedWasteland" then payload = { mode = "polluted", count = 1 }
                elseif CurrentMode == "Badlands" then payload = { mode = "badlands", count = 1 }
                else payload = { difficulty = CurrentMode, mode = "survival", count = 1 } end
                return remote:InvokeServer("Multiplayer", "v2:start", payload)
            end)

            if ok and CheckResOk(result) then
                success = true
                res = result
            else
                task.wait(0.5) 
            end
        else
            task.wait(1)
        end
    until success
    return res
end

local function HandlePostMatch()
    local UiRoot
    repeat
        task.wait(1)
        local root = PlayerGui:FindFirstChild("ReactGameNewRewards")
        local frame = root and root:FindFirstChild("Frame")
        local gameOver = frame and frame:FindFirstChild("gameOver")
        local RewardsScreen = gameOver and gameOver:FindFirstChild("RewardsScreen")
        UiRoot = RewardsScreen and RewardsScreen:FindFirstChild("RewardsSection")
    until UiRoot

    if not UiRoot then return RejoinMatch() end
    if not Globals.AutoRejoin then return end

    if not Globals.SendWebhook then
        RejoinMatch()
        return
    end

    task.wait(1)
    local match = GetAllRewards()
    CurrentTotalCoins += match.Coins
    CurrentTotalGems += match.Gems

    local BonusString = ""
    if #match.Others > 0 then
        for _, res in ipairs(match.Others) do
            BonusString = BonusString .. "🎁 **" .. res.Amount .. " " .. res.Name .. "**\n"
        end
    else
        BonusString = "_No bonus rewards found._"
    end

    local PostData = {
        username = "TDS AutoStrat",
        embeds = {{
            title = (match.Status == "WIN" and "🏆 TRIUMPH" or "💀 DEFEAT"),
            color = (match.Status == "WIN" and 0x2ecc71 or 0xe74c3c),
            description =
                "### 📋 Match Overview\n" ..
                "> **Status:** `" .. match.Status .. "`\n" ..
                "> **Time:** `" .. match.Time .. "`\n" ..
                "> **Current Level:** `" .. match.Level .. "`\n" ..
                "> **Wave:** `" .. match.Wave .. "`\n",
            fields = {
                { name = "✨ Rewards", value = "```ansi\n [2;33mCoins: [0m +" .. match.Coins .. "\n [2;34mGems:  [0m +" .. match.Gems .. "\n [2;32mXP:    [0m +" .. match.XP .. "```", inline = false },
                { name = "🎁 Bonus Items", value = BonusString, inline = true },
                { name = "📊 Session Totals", value = "```py\n# Total Amount\nCoins: " .. CurrentTotalCoins .. "\nGems:  " .. CurrentTotalGems .. "```", inline = true }
            },
            footer = { text = "Logged for " .. LocalPlayer.Name .. " • TDS AutoStrat" },
            timestamp = DateTime.now():ToIsoDate()
        }}
    }

    pcall(function()
        SendRequest({
            Url = Globals.WebhookURL, Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = game:GetService("HttpService"):JSONEncode(PostData)
        })
    end)

    task.wait(1.5)
    RejoinMatch()
end

local function RunVoteSkip()
    while true do
        local success = pcall(function() RemoteFunc:InvokeServer("Voting", "Skip") end)
        if success then break end
        task.wait(0.2)
    end
end

local function MatchReadyUp()
    local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    local UiOverrides = PlayerGui:WaitForChild("ReactOverridesVote", 30)
    local MainFrame = UiOverrides and UiOverrides:WaitForChild("Frame", 30)
    if not MainFrame then return end

    local VoteReady = nil
    while not VoteReady do
        local VoteNode = MainFrame:FindFirstChild("votes")
        if VoteNode then
            local container = VoteNode:FindFirstChild("container")
            if container then
                local ready = container:FindFirstChild("ready")
                if ready then VoteReady = ready end
            end
        end
        if not VoteReady then task.wait(0.5) end
    end
    repeat task.wait(0.1) until VoteReady.Visible == true
    RunVoteSkip()
end

local function CastMapVote(MapId, PosVec)
    local TargetMap = MapId or "Simplicity"
    local TargetPos = PosVec or Vector3.new(0,0,0)
    RemoteEvent:FireServer("LobbyVoting", "Vote", TargetMap, TargetPos)
    if Logger then Logger:Log("Cast map vote: " .. TargetMap) end
end

local function LobbyReadyUp()
    pcall(function()
        RemoteEvent:FireServer("LobbyVoting", "Ready")
        if Logger then Logger:Log("Lobby ready up sent") end
    end)
end

local function SelectMapOverride(MapId, ...)
    local args = {...}
    if args[#args] == "vip" then RemoteFunc:InvokeServer("LobbyVoting", "Override", MapId) end
    task.wait(3)
    CastMapVote(MapId, Vector3.new(12.59, 10.64, 52.01))
    task.wait(1)
    LobbyReadyUp()
    MatchReadyUp()
end

local function CastModifierVote(ModsTable)
    local BulkModifiers = ReplicatedStorage:WaitForChild("Network"):WaitForChild("Modifiers"):WaitForChild("RF:BulkVoteModifiers")
    local SelectedMods = {}
    if ModsTable and #ModsTable > 0 then
        for _, modName in ipairs(ModsTable) do SelectedMods[modName] = true end
    end
    pcall(function()
        BulkModifiers:InvokeServer(SelectedMods)
        if Logger then Logger:Log("Successfully casted modifier votes.") end
    end)
end

local function IsMapAvailable(name)
    for _, g in ipairs(workspace:GetDescendants()) do
        if g:IsA("SurfaceGui") and g.Name == "MapDisplay" then
            local t = g:FindFirstChild("Title")
            if t and t.Text == name then return true end
        end
    end

    repeat
        local IntermissionFrame = PlayerGui:WaitForChild("ReactGameIntermission"):WaitForChild("Frame")
        local VetoText = IntermissionFrame:WaitForChild("buttons"):WaitForChild("veto"):WaitForChild("value").Text
        if IntermissionFrame.Visible and VetoText:match("Veto %(0/") then RemoteEvent:FireServer("LobbyVoting", "Veto") end
        wait(1)
        local found = false
        for _, g in ipairs(workspace:GetDescendants()) do
            if g:IsA("SurfaceGui") and g.Name == "MapDisplay" then
                local t = g:FindFirstChild("Title")
                if t and t.Text == name then
                    found = true
                    break
                end
            end
        end
        local TotalPlayer = #PlayersService:GetChildren()
    until found or VetoText == "Veto ("..TotalPlayer.."/"..TotalPlayer..")"

    for _, g in ipairs(workspace:GetDescendants()) do
        if g:IsA("SurfaceGui") and g.Name == "MapDisplay" then
            local t = g:FindFirstChild("Title")
            if t and t.Text == name then return true end
        end
    end
    return false
end

local function SetGameTimescale(TargetVal)
    if GameState ~= "GAME" then return false end
    local SpeedList = {0, 0.5, 1, 1.5, 2}
    local TargetIdx
    for i, v in ipairs(SpeedList) do if v == TargetVal then TargetIdx = i break end end
    if not TargetIdx then return end

    local SpeedLabel = game.Players.LocalPlayer.PlayerGui.ReactUniversalHotbar.Frame.timescale.Speed
    local CurrentVal = tonumber(SpeedLabel.Text:match("x([%d%.]+)"))
    if not CurrentVal then return end

    local CurrentIdx
    for i, v in ipairs(SpeedList) do if v == CurrentVal then CurrentIdx = i break end end
    if not CurrentIdx then return end

    local diff = TargetIdx - CurrentIdx
    if diff < 0 then diff = #SpeedList + diff end

    for _ = 1, diff do
        ReplicatedStorage.RemoteFunction:InvokeServer("TicketsManager", "CycleTimeScale")
        task.wait(0.5)
    end
end

local function UnlockSpeedTickets()
    if GameState ~= "GAME" then return false end
    if LocalPlayer.TimescaleTickets.Value >= 1 then
        if game.Players.LocalPlayer.PlayerGui.ReactUniversalHotbar.Frame.timescale.Lock.Visible then
            ReplicatedStorage.RemoteFunction:InvokeServer('TicketsManager', 'UnlockTimeScale')
            if Logger then Logger:Log("Unlocked timescale tickets") end
        end
    else
        if Logger then Logger:Log("No timescale tickets left") end
    end
end

ApplyTimeScaleOnce = function()
    if not Globals.TimeScaleEnabled or GameState ~= "GAME" then return end
    local frame = GetTimescaleFrame()
    if not frame or not frame.Visible then return end
    local desired = CoerceTimeScaleValue(Globals.TimeScaleValue, 2)
    if not desired then return end

    local lock = frame:FindFirstChild("Lock")
    if lock and lock.Visible then
        if LocalPlayer.TimescaleTickets.Value < 1 then
            if not TimeScaleNoTicketsWarned then
                if Logger then Logger:Log("No timescale tickets left") end
                TimeScaleNoTicketsWarned = true
            end
            return
        end
        UnlockSpeedTickets()
        task.wait(0.4)
    else
        TimeScaleNoTicketsWarned = false
    end
    SetGameTimescale(desired)
end

StartTimeScale = function()
    if TimeScaleRunning or not Globals.TimeScaleEnabled then return end
    TimeScaleRunning = true
    task.spawn(function()
        while Globals.TimeScaleEnabled do
            ApplyTimeScaleOnce()
            task.wait(3)
        end
        TimeScaleNoTicketsWarned = false
        TimeScaleRunning = false
    end)
end

local function TriggerRestart()
    local UiRoot = PlayerGui:WaitForChild("ReactGameNewRewards")
    local FoundSection = false
    repeat
        task.wait(0.3)
        local f = UiRoot:FindFirstChild("Frame")
        local g = f and f:FindFirstChild("gameOver")
        local s = g and g:FindFirstChild("RewardsScreen")
        if s and s:FindFirstChild("RewardsSection") then FoundSection = true end
    until FoundSection
    task.wait(3)
    RunVoteSkip()
end

local function GetCurrentWave()
    local label
    repeat
        task.wait(0.5)
        label = PlayerGui:FindFirstChild("ReactGameTopGameDisplay", true) 
            and PlayerGui.ReactGameTopGameDisplay.Frame.wave.container:FindFirstChild("value")
    until label ~= nil
    local text = label.Text
    local WaveNum = text:match("(%d+)")
    return tonumber(WaveNum) or 0
end

local function DoPlaceTower(TName, TPos)
    if Logger then Logger:Log("Placing tower: " .. TName) end
    while true do
        local ok, res = pcall(function() return RemoteFunc:InvokeServer("Troops", "Pl\208\176ce", {Rotation = CFrame.new(), Position = TPos}, TName) end)
        if ok and CheckResOk(res) then return true end
        task.wait(0.25)
    end
end

local function DoUpgradeTower(TObj, PathId)
    while true do
        local ok, res = pcall(function() return RemoteFunc:InvokeServer("Troops", "Upgrade", "Set", {Troop = TObj, Path = PathId}) end)
        if ok and CheckResOk(res) then return true end
        task.wait(0.25)
    end
end

local function DoSellTower(TObj)
    while true do
        local ok, res = pcall(function() return RemoteFunc:InvokeServer("Troops", "Sell", { Troop = TObj }) end)
        if ok and CheckResOk(res) then return true end
        task.wait(0.25)
    end
end

local function DoSetOption(TObj, OptName, OptVal, ReqWave)
    if ReqWave then repeat task.wait(0.3) until GetCurrentWave() >= ReqWave end
    while true do
        local ok, res = pcall(function() return RemoteFunc:InvokeServer("Troops", "Option", "Set", {Troop = TObj, Name = OptName, Value = OptVal}) end)
        if ok and CheckResOk(res) then return true end
        task.wait(0.25)
    end
end

local function DoActivateAbility(TObj, AbName, AbData, IsLooping)
    if type(AbData) == "boolean" then
        IsLooping = AbData
        AbData = nil
    end
    AbData = type(AbData) == "table" and AbData or nil

    local positions
    if AbData and type(AbData.towerPosition) == "table" then positions = AbData.towerPosition end
    local CloneIdx = AbData and AbData.towerToClone
    local TargetIdx = AbData and AbData.towerTarget

    local function attempt()
        while true do
            local ok, res = pcall(function()
                local data
                if AbData then
                    data = table.clone(AbData)
                    if positions and #positions > 0 then data.towerPosition = positions[math.random(#positions)] end
                    if type(CloneIdx) == "number" then data.towerToClone = TDS.PlacedTowers[CloneIdx] end
                    if type(TargetIdx) == "number" then data.towerTarget = TDS.PlacedTowers[TargetIdx] end
                end
                return RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", {Troop = TObj, Name = AbName, Data = data})
            end)
            if ok and CheckResOk(res) then return true end
            task.wait(0.25)
        end
    end

    if IsLooping then
        local active = true
        task.spawn(function()
            while active do
                attempt()
                task.wait(1)
            end
        end)
        return function() active = false end
    end
    return attempt()
end

-- // Feature Activators
local function StartAutoSkip()
    if AutoSkipRunning or not Globals.AutoSkip then return end
    AutoSkipRunning = true
    task.spawn(function()
        while Globals.AutoSkip do
            local SkipVisible =
                PlayerGui:FindFirstChild("ReactOverridesVote")
                and PlayerGui.ReactOverridesVote:FindFirstChild("Frame")
                and PlayerGui.ReactOverridesVote.Frame:FindFirstChild("votes")
                and PlayerGui.ReactOverridesVote.Frame.votes:FindFirstChild("vote")

            if SkipVisible and SkipVisible.Position == UDim2.new(0.5, 0, 0.5, 0) then
                RunVoteSkip()
            end
            task.wait(1)
        end
        AutoSkipRunning = false
    end)
end

local function StartBackToLobby()
    if BackToLobbyRunning then return end
    BackToLobbyRunning = true
    task.spawn(function()
        while true do
            pcall(function() HandlePostMatch() end)
            task.wait(5)
        end
        BackToLobbyRunning = false
    end)
end

local function StartAntiLag()
    if AntiLagRunning then return end
    AntiLagRunning = true
    local settings_rendering = settings().Rendering
    settings_rendering.QualityLevel = Enum.QualityLevel.Level01

    task.spawn(function()
        while Globals.AntiLag do
            local TowersFolder = workspace:FindFirstChild("Towers")
            local ClientUnits = workspace:FindFirstChild("ClientUnits")
            local enemies = workspace:FindFirstChild("NPCs")

            if TowersFolder then
                for _, tower in ipairs(TowersFolder:GetChildren()) do
                    local anims = tower:FindFirstChild("Animations")
                    local weapon = tower:FindFirstChild("Weapon")
                    local projectiles = tower:FindFirstChild("Projectiles")
                    if anims then anims:Destroy() end
                    if projectiles then projectiles:Destroy() end
                    if weapon then weapon:Destroy() end
                end
            end
            if ClientUnits then
                for _, unit in ipairs(ClientUnits:GetChildren()) do unit:Destroy() end
            end
            if enemies then
                for _, npc in ipairs(enemies:GetChildren()) do npc:Destroy() end
            end
            task.wait(0.5)
        end
        AntiLagRunning = false
    end)
end

local function StartAutoChain()
    if AutoChainRunning or not Globals.AutoChain then return end
    AutoChainRunning = true
    task.spawn(function()
        local idx = 1
        while Globals.AutoChain do
            local commander = {}
            local TowersFolder = workspace:FindFirstChild("Towers")

            if TowersFolder then
                for _, tower in ipairs(TowersFolder:GetChildren()) do
                    local rep = tower:FindFirstChild("TowerReplicator")
                    if rep and rep:GetAttribute("Name") == "Commander" and rep:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId and (rep:GetAttribute("Upgrade") or 0) >= 2 then
                        commander[#commander + 1] = tower
                    end
                end
            end

            if #commander >= 3 then
                if idx > #commander then idx = 1 end
                local CurrentCommander = commander[idx]
                local replicator = CurrentCommander:FindFirstChild("TowerReplicator")
                local UpgradeLevel = replicator and replicator:GetAttribute("Upgrade") or 0

                if UpgradeLevel >= 4 and Globals.SupportCaravan then
                    RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", { Troop = CurrentCommander, Name = "Support Caravan", Data = {} })
                    task.wait(0.1) 
                end

                local response = RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", { Troop = CurrentCommander, Name = "Call Of Arms", Data = {} })

                if response then
                    idx += 1
                    local hotbar = PlayerGui:FindFirstChild("ReactUniversalHotbar")
                    local TimescaleFrame = hotbar and hotbar.Frame:FindFirstChild("timescale")
                    if TimescaleFrame and TimescaleFrame.Visible then
                        if TimescaleFrame:FindFirstChild("Lock") then
                            task.wait(10.3)
                        else
                            task.wait(5.25)
                        end
                    else
                        task.wait(10.3)
                    end
                else
                    task.wait(0.5)
                end
            else
                task.wait(1)
            end
        end
        AutoChainRunning = false
    end)
end

local function StartAutoDjBooth()
    if AutoDjRunning or not Globals.AutoDJ then return end
    AutoDjRunning = true
    task.spawn(function()
        while Globals.AutoDJ do
            local TowersFolder = workspace:FindFirstChild("Towers")
            local DJ = nil
            if TowersFolder then
                for _, tower in ipairs(TowersFolder:GetChildren()) do
                    local rep = tower:FindFirstChild("TowerReplicator")
                    if rep and rep:GetAttribute("Name") == "DJ Booth" and rep:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId and (rep:GetAttribute("Upgrade") or 0) >= 3 then
                        DJ = tower
                        break
                    end
                end
            end
            if DJ then
                RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", { Troop = DJ, Name = "Drop The Beat", Data = {} })
            end
            task.wait(1)
        end
        AutoDjRunning = false
    end)
end

local function StartAutoNecro()
    if AutoNecroRunning or not Globals.AutoNecro then return end
    AutoNecroRunning = true

    local lastActivation = 0
    local ownerId = game.Players.LocalPlayer.UserId

    local function getNecros(towersFolder)
        local list = {}
        if not towersFolder then return list end
        for _, tower in ipairs(towersFolder:GetChildren()) do
            local rep = tower:FindFirstChild("TowerReplicator")
            if rep and rep:GetAttribute("Name") == "Necromancer" and rep:GetAttribute("OwnerId") == ownerId then
                list[#list + 1] = tower
            end
        end
        return list
    end

    local function pickMaxGraves(rep, graveStore, up)
        local maxGraves = rep and rep:GetAttribute("Max_Graves")
        if graveStore then
            local gMax = graveStore:GetAttribute("Max_Graves")
            if type(gMax) == "number" and gMax > 0 then maxGraves = gMax end
        end
        if not maxGraves or maxGraves < 2 then
            if up >= 4 then maxGraves = 9
            elseif up >= 2 then maxGraves = 6
            else maxGraves = 3 end
        end
        return maxGraves
    end

    local function countGraves(graveStore)
        if not graveStore then return 0 end
        local cnt = 0
        for k, v in pairs(graveStore:GetAttributes()) do
            if type(k) == "string" and #k > 20 then
                local isDestroy = false
                if type(v) == "table" then
                    for _, elem in pairs(v) do
                        if tostring(elem) == "Destroy" then isDestroy = true break end
                    end
                elseif tostring(v):find("Destroy") then
                    isDestroy = true
                end
                if isDestroy then
                    graveStore:SetAttribute(k, nil)
                else
                    cnt += 1
                end
            end
        end
        return cnt
    end

    local function cleanAllGraves(list)
        for _, necro in ipairs(list) do
            local rep = necro and necro:FindFirstChild("TowerReplicator")
            local store = rep and rep:FindFirstChild("GraveStone")
            if store then countGraves(store) end
        end
    end

    task.spawn(function()
        local idx = 1
        while Globals.AutoNecro do
            local TowersFolder = workspace:FindFirstChild("Towers")
            local necromancer = getNecros(TowersFolder)
            cleanAllGraves(necromancer)

            if #necromancer >= 1 then
                if idx > #necromancer then idx = 1 end
                local CurrentNecromancer = necromancer[idx]
                local replicator = CurrentNecromancer:FindFirstChild("TowerReplicator")

                local up = replicator and (replicator:GetAttribute("Upgrade") or 0) or 0
                local graveStore = replicator and replicator:FindFirstChild("GraveStone")
                local maxGraves = pickMaxGraves(replicator, graveStore, up)
                local graveCount = countGraves(graveStore)
                local debounce = (replicator and replicator:GetAttribute("AbilityDebounce")) or 5
                local now = os.clock()

                if maxGraves and graveCount >= maxGraves and (now - lastActivation >= debounce) then
                    local response = RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", { Troop = CurrentNecromancer, Name = "Raise The Dead", Data = {} })
                    if response then 
                        lastActivation = now
                        idx += 1
                        task.wait(1)
                    else
                        task.wait(0.5)
                    end
                else
                    task.wait(0.1)
                end
            else
                task.wait(1)
            end
        end
        AutoNecroRunning = false
    end)
end

local function StartAutoMercenary()
    if not Globals.AutoMercenary then return end
    if AutoMercenaryBaseRunning then return end
    AutoMercenaryBaseRunning = true

    task.spawn(function()
        while Globals.AutoMercenary do
            local TowersFolder = workspace:FindFirstChild("Towers")
            if TowersFolder then
                for _, tower in ipairs(TowersFolder:GetChildren()) do
                    local rep = tower:FindFirstChild("TowerReplicator")
                    if rep and rep:GetAttribute("Name") == "Mercenary Base" and rep:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId and (rep:GetAttribute("Upgrade") or 0) >= 5 then
                        RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", { Troop = tower, Name = "Air-Drop", Data = {pathName = 1, directionCFrame = CFrame.new(), dist = Globals.MercenaryPath or 195} })
                        task.wait(0.5)
                        if not Globals.AutoMercenary then break end
                    end
                end
            end
            task.wait(0.5)
        end
        AutoMercenaryBaseRunning = false
    end)
end

local function StartAutoMilitary()
    if not Globals.AutoMilitary then return end
    if AutoMilitaryBaseRunning then return end
    AutoMilitaryBaseRunning = true

    task.spawn(function()
        while Globals.AutoMilitary do
            local TowersFolder = workspace:FindFirstChild("Towers")
            if TowersFolder then
                for _, tower in ipairs(TowersFolder:GetChildren()) do
                    local rep = tower:FindFirstChild("TowerReplicator")
                    if rep and rep:GetAttribute("Name") == "Military Base" and rep:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId and (rep:GetAttribute("Upgrade") or 0) >= 4 then
                        RemoteFunc:InvokeServer("Troops", "Abilities", "Activate", { Troop = tower, Name = "Airstrike", Data = {pathName = 1, pointToEnd = CFrame.new(), dist = Globals.MilitaryPath or 195} })
                        task.wait(0.5)
                        if not Globals.AutoMilitary then break end
                    end
                end
            end
            task.wait(0.5)
        end
        AutoMilitaryBaseRunning = false
    end)
end

local function StartSellFarm()
    if SellFarmsRunning or not Globals.SellFarms then return end
    SellFarmsRunning = true

    if GameState ~= "GAME" then return false end

    task.spawn(function()
        while Globals.SellFarms do
            local CurrentWave = GetCurrentWave()
            if Globals.SellFarmsWave and CurrentWave < Globals.SellFarmsWave then
                task.wait(1)
                continue
            end

            local TowersFolder = workspace:FindFirstChild("Towers")
            if TowersFolder then
                for _, tower in ipairs(TowersFolder:GetChildren()) do
                    local rep = tower:FindFirstChild("TowerReplicator")
                    if rep then
                        local IsFarm = rep:GetAttribute("Name") == "Farm"
                        local IsMine = rep:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId

                        if IsFarm and IsMine then
                            RemoteFunc:InvokeServer("Troops", "Sell", { Troop = tower })
                            task.wait(0.2)
                        end
                    end
                end
            end
            task.wait(1)
        end
        SellFarmsRunning = false
    end)
end

local AutoGatlingRunning = false

local function StartAutoGatling()
    if AutoGatlingRunning or not Globals.AutoGatling then return end
    AutoGatlingRunning = true

    task.spawn(function()
        local RS = game:GetService("ReplicatedStorage")
        local success, NewNetwork = pcall(require, RS.Shared.Modules.NewNetwork)
        
        if not success then 
            AutoGatlingRunning = false 
            return 
        end
        
        local GatlingChannel = NewNetwork.Channel("GatlingGun")

        while Globals.AutoGatling do
            if GameState == "GAME" then
                local TowersFolder = workspace:FindFirstChild("Towers")
                local npcs = workspace:FindFirstChild("NPCs")

                if TowersFolder and npcs then
                    for _, tower in ipairs(TowersFolder:GetChildren()) do
                        local rep = tower:FindFirstChild("TowerReplicator")
                        
                        -- Cek apakah tower ini Gatling Gun dan milik kita
                        if rep and rep:GetAttribute("Name") == "Default" and rep:GetAttribute("OwnerId") == game.Players.LocalPlayer.UserId then

                            local ammo = rep:GetAttribute("Ammo") or 0
                            local reloading = rep:GetAttribute("Reloading")

                            if ammo <= 0 and not reloading then
                                -- Otomatis Reload jika peluru habis
                                pcall(function() GatlingChannel:fireServer("Reload") end)
                            elseif ammo > 0 and not reloading then
                                -- Cari musuh terdekat (Aimbot logic)
                                local root = tower:FindFirstChild("HumanoidRootPart") or tower.PrimaryPart
                                if root then
                                    local bestPos = nil
                                    local closestDist = 120 -- Jangkauan maksimal Gatling (Bisa disesuaikan)

                                    for _, npc in ipairs(npcs:GetChildren()) do
                                        local hrp = npc:FindFirstChild("HumanoidRootPart")
                                        local hum = npc:FindFirstChild("Humanoid")
                                        
                                        if hrp and hum and hum.Health > 0 then
                                            local dist = (hrp.Position - root.Position).Magnitude
                                            if dist < closestDist then
                                                closestDist = dist
                                                bestPos = hrp.Position
                                            end
                                        end
                                    end

                                    if bestPos then
                                        pcall(function()
                                            -- 1. Beritahu server kita "masuk" FPS mode (agar damage & piercing tembus)
                                            GatlingChannel:fireServer("FpsEnabled", true)
                                            -- 2. Arahkan Gatling ke koordinat musuh
                                            GatlingChannel:fireUnreliableServer("ReplicateAimPosition", bestPos)
                                            -- 3. Tembak!
                                            GatlingChannel:fireServer("Fire", bestPos, workspace:GetAttribute("Sync"), workspace:GetServerTimeNow())
                                        end)
                                    else
                                        -- Jika tidak ada musuh, hentikan tembakan agar peluru tidak terbuang
                                        pcall(function() GatlingChannel:fireServer("StopFiring") end)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.08) -- Delay 0.08s (menyamai fire-rate minigun agar tidak di kick karena spam)
        end
        AutoGatlingRunning = false
    end)
end

-- ==========================================
-- // PUBLIC API (For Strategy Scripts)
-- ==========================================

-- // Lobby
function TDS:Mode(difficulty)
    if GameState ~= "LOBBY" then return false end
    local LobbyHud = PlayerGui:WaitForChild("ReactLobbyHud", 30)
    local frame = LobbyHud and LobbyHud:WaitForChild("Frame", 30)
    local MatchMaking = frame and frame:WaitForChild("matchmaking", 30)

    if MatchMaking then
        local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction")
        local success = false
        local res
        repeat
            local ok, result = pcall(function()
                local mode = TDS.MatchmakingMap[difficulty]
                local payload
                if mode then
                    payload = { mode = mode, count = 1 }
                else
                    payload = { difficulty = difficulty, mode = "survival", count = 1 }
                end
                return remote:InvokeServer("Multiplayer", "v2:start", payload)
            end)

            if ok and CheckResOk(result) then
                success = true
                res = result
            else
                task.wait(0.5) 
            end
        until success
    end
    return true
end

function TDS:Loadout(...)
    if GameState ~= "LOBBY" and GameState ~= "GAME" then return end
    local towers = {...}
    local remote = game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction")
    local StateReplicators = ReplicatedStorage:FindFirstChild("StateReplicators")

    local CurrentlyEquipped = {}
    if StateReplicators then
        for _, folder in ipairs(StateReplicators:GetChildren()) do
            if folder.Name == "PlayerReplicator" and folder:GetAttribute("UserId") == LocalPlayer.UserId then
                local EquippedAttr = folder:GetAttribute("EquippedTowers")
                if type(EquippedAttr) == "string" then
                    local CleanedJson = EquippedAttr:match("%[.*%]") 
                    local DecodeSuccess, decoded = pcall(function() return HttpService:JSONDecode(CleanedJson) end)
                    if DecodeSuccess and type(decoded) == "table" then
                        CurrentlyEquipped = decoded
                    end
                end
            end
        end
    end

    for _, CurrentTower in ipairs(CurrentlyEquipped) do
        if CurrentTower ~= "None" then
            local UnequipDone = false
            repeat
                local ok = pcall(function()
                    remote:InvokeServer("Inventory", "Unequip", "tower", CurrentTower)
                    task.wait(0.3)
                end)
                if ok then UnequipDone = true else task.wait(0.2) end
            until UnequipDone
        end
    end

    task.wait(0.5)

    for _, TowerName in ipairs(towers) do
        if TowerName and TowerName ~= "" then
            local EquipSuccess = false
            repeat
                local ok = pcall(function()
                    remote:InvokeServer("Inventory", "Equip", "tower", TowerName)
                    if Logger then Logger:Log("Equipped tower: " .. TowerName) end
                    task.wait(0.3)
                end)
                if ok then EquipSuccess = true else task.wait(0.2) end
            until EquipSuccess
        end
    end

    task.wait(0.5)
    return true
end

-- // Ingame
function TDS:VoteSkip(StartWave, EndWave)
    task.spawn(function()
        local CurrentWave = GetCurrentWave()
        StartWave = StartWave or (CurrentWave > 0 and CurrentWave or 1)
        EndWave = EndWave or StartWave

        for wave = StartWave, EndWave do
            while GetCurrentWave() < wave do task.wait(1) end

            local SkipDone = false
            while not SkipDone do
                local VoteUi = PlayerGui:FindFirstChild("ReactOverridesVote")
                local VoteButton = VoteUi and VoteUi:FindFirstChild("Frame") and VoteUi.Frame:FindFirstChild("votes") and VoteUi.Frame.votes:FindFirstChild("vote", true)

                if VoteButton and VoteButton.Position == UDim2.new(0.5, 0, 0.5, 0) then
                    RunVoteSkip()
                    SkipDone = true
                    if Logger then Logger:Log("Voted to skip wave " .. wave) end
                else
                    if GetCurrentWave() > wave then break end
                    task.wait(0.5)
                end
            end
        end
    end)
end

function TDS:GameInfo(name, list)
    if GameState ~= "GAME" then return false end
    local VoteGui = PlayerGui:WaitForChild("ReactGameIntermission", 30)
    if not (VoteGui and VoteGui.Enabled and VoteGui:WaitForChild("Frame", 5)) then return end

    local modifiers = (list and #list > 0) and list or Globals.Modifiers
    CastModifierVote(modifiers)

    if MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 10518590) then
        SelectMapOverride(name, "vip")
        if Logger then Logger:Log("Selected map: " .. name) end
        repeat task.wait(1) until PlayerGui:FindFirstChild("ReactUniversalHotbar")
        return true 
    elseif IsMapAvailable(name) then
        SelectMapOverride(name)
        repeat task.wait(1) until PlayerGui:FindFirstChild("ReactUniversalHotbar")
        return true
    else
        if Logger then Logger:Log("Map '" .. name .. "' not available, rejoining...") end
        TeleportService:Teleport(3260590327, LocalPlayer)
        repeat task.wait(9999) until false
    end
end

function TDS:UnlockTimeScale() UnlockSpeedTickets() end
function TDS:TimeScale(val) SetGameTimescale(val) end
function TDS:StartGame() LobbyReadyUp() end

function TDS:Ready()
    if GameState ~= "GAME" then return false end
    MatchReadyUp()
end

function TDS:GetWave() return GetCurrentWave() end
function TDS:RestartGame() TriggerRestart() end

function TDS:Place(TName, px, py, pz, ...)
    local args = {...}
    if args[#args] == "stack" or args[#args] == true then py = py + 20 end
    if GameState ~= "GAME" then return false end

    local existing = {}
    for _, child in ipairs(workspace.Towers:GetChildren()) do
        for _, SubChild in ipairs(child:GetChildren()) do
            if SubChild.Name == "Owner" and SubChild.Value == LocalPlayer.UserId then
                existing[child] = true
                break
            end
        end
    end

    DoPlaceTower(TName, Vector3.new(px, py, pz))

    local NewT
    repeat
        for _, child in ipairs(workspace.Towers:GetChildren()) do
            if not existing[child] then
                for _, SubChild in ipairs(child:GetChildren()) do
                    if SubChild.Name == "Owner" and SubChild.Value == LocalPlayer.UserId then
                        NewT = child
                        break
                    end
                end
            end
            if NewT then break end
        end
        task.wait(0.05)
    until NewT

    table.insert(self.PlacedTowers, NewT)
    return #self.PlacedTowers
end

function TDS:Upgrade(idx, PId)
    local t = self.PlacedTowers[idx]
    if t then
        DoUpgradeTower(t, PId or 1)
        if Logger then Logger:Log("Upgrading tower index: " .. idx) end
        UpgradeHistory[idx] = (UpgradeHistory[idx] or 0) + 1
    end
end

function TDS:SetTarget(idx, TargetType, ReqWave)
    if ReqWave then repeat task.wait(0.5) until GetCurrentWave() >= ReqWave end
    local t = self.PlacedTowers[idx]
    if not t then return end

    pcall(function()
        RemoteFunc:InvokeServer("Troops", "Target", "Set", { Troop = t, Target = TargetType })
        if Logger then Logger:Log("Set target for tower index " .. idx .. " to " .. TargetType) end
    end)
end

function TDS:Sell(idx, ReqWave)
    if ReqWave then repeat task.wait(0.5) until GetCurrentWave() >= ReqWave end
    local t = self.PlacedTowers[idx]
    if t and DoSellTower(t) then return true end
    return false
end

function TDS:SellAll(ReqWave)
    task.spawn(function()
        if ReqWave then repeat task.wait(0.5) until GetCurrentWave() >= ReqWave end
        local TowersCopy = {unpack(self.PlacedTowers)}
        for idx, t in ipairs(TowersCopy) do
            if DoSellTower(t) then
                for i, OrigT in ipairs(self.PlacedTowers) do
                    if OrigT == t then
                        table.remove(self.PlacedTowers, i)
                        break
                    end
                end
            end
        end
        return true
    end)
end

function TDS:Ability(idx, name, data, loop)
    local t = self.PlacedTowers[idx]
    if not t then return false end
    if Logger then Logger:Log("Activating ability '" .. name .. "' for tower index: " .. idx) end
    return DoActivateAbility(t, name, data, loop)
end

function TDS:AutoChain(...)
    local TowerIndices = {...}
    if #TowerIndices == 0 then return end
    local running = true

    task.spawn(function()
        local i = 1
        while running do
            local idx = TowerIndices[i]
            local tower = TDS.PlacedTowers[idx]
            if tower then DoActivateAbility(tower, "Call Of Arms") end

            local hotbar = PlayerGui:FindFirstChild("ReactUniversalHotbar")
            local timescale = hotbar and hotbar:FindFirstChild("Frame") and hotbar.Frame:FindFirstChild("timescale")

            if timescale then
                if timescale:FindFirstChild("Lock") then task.wait(10.5) else task.wait(5.5) end
            else
                task.wait(10.5)
            end

            i += 1
            if i > #TowerIndices then i = 1 end
        end
    end)
    return function() running = false end
end

function TDS:SetOption(idx, name, val, ReqWave)
    local t = self.PlacedTowers[idx]
    if t then
        if Logger then Logger:Log("Setting option '" .. name .. "' for tower index: " .. idx) end
        return DoSetOption(t, name, val, ReqWave)
    end
    return false
end

task.spawn(function()
    while true do
        if Globals.AutoSkip and not AutoSkipRunning then StartAutoSkip() end
        if Globals.TimeScaleEnabled and not TimeScaleRunning then StartTimeScale() end
        if Globals.AutoChain and not AutoChainRunning then StartAutoChain() end
        if Globals.AutoDJ and not AutoDjRunning then StartAutoDjBooth() end
        if Globals.AutoNecro and not AutoNecroRunning then StartAutoNecro() end
        if Globals.AutoMercenary and not AutoMercenaryBaseRunning then StartAutoMercenary() end
        if Globals.AutoMilitary and not AutoMilitaryBaseRunning then StartAutoMilitary() end
        if Globals.SellFarms and not SellFarmsRunning then StartSellFarm() end
        if Globals.AntiLag and not AntiLagRunning then StartAntiLag() end
        if Globals.AutoRejoin and not BackToLobbyRunning then StartBackToLobby() end
        if Globals.AutoGatling and not AutoGatlingRunning then StartAutoGatling() end
        task.wait(1)
    end
end)

return TDS
