data = {}
posx1, posy1, posx2, posy2 = nil, nil, nil, nil
local itemIDList = {7188, 1796, 242}
local gemID = 112
local idc = 5640
local taxset = 0
local DropMode = false
local dwl = false
local ddl = false
local dbgl = false
local cdp = false
local cdrop = false
local dawlock = false
local cdl = false
local cbgl = false
local cblk = false
local acbgl = false
local fbgl = false
local win1 = false
local win2 = false
local pph = false
local ppv = false
local firstnum = ""
local op = ""
local secondnum = ""
local spamText = ""
local delay = 0
local spamTextActive = false
local pull = false
local kick = false
local ban = false
local gas = false
local reme = true
local qeme = false
local leme = false
local wrenchmode = "`7Default"
systemlog = "`w[`1P`3r`1o`3x`1y `3b`1y `3S`1c`3r`1i`3p`1t`3i`1n`3g `1C`3r`1e`3a`1t`3i`1v`3e`1P`3S`w]** "
selectedPlayers = {} 
playerLogs = {}      

function log(str)
LogToConsole(systemlog.."`o"..str)
end

servers=function(t, s, v, x, y);SendPacketRaw(false, {type = t, state = s, value = v, px = x, py = y, x = x * 32, y = y * 32});end

function ovl(str)
ov = {}
ov[0] = "OnTextOverlay"
ov[1] = str
SendVariantList(ov)
end

function drop(id, amount)  
SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|"..id.."|\nitem_count|"..amount.."\n\n")
end

function tap(id)
ct = {}
ct.type = 10
ct.value = id
SendPacketRaw(false, ct)
end

function cekinv(id)
    for _, inv in pairs(GetInventory()) do
        if inv.id == id then
            return inv.amount
        end
    end
    return 0
end


function taps(id, id2, amount)
for _, inv in pairs(GetInventory()) do
if inv.id == id then
if inv.amount < amount then
ct = {}
ct.x = 0
ct.y = 0
ct.type = 10
ct.value = id2
ct.px = 0
ct.py = 0
ct.state = 0
ct.netid = 0
SendPacketRaw(false, ct)
end
end
end
end

function collectItems()
    if not (posx1 and posy1 and posx2 and posy2) then
        log("`4Error: position has not been set")
        return
    end
    local minX, maxX = math.min(posx1, posx2), math.max(posx1, posx2)
    local minY, maxY = math.min(posy1, posy2), math.max(posy1, posy2)
    for _, obj in pairs(GetObjectList()) do
        local objX, objY = math.floor(obj.pos.x / 32), math.floor(obj.pos.y / 32)
        if objX >= minX and objX <= maxX and objY >= minY and objY <= maxY and table.contains(itemIDList, obj.id) then
            local packet = {type = 11, value = obj.oid, x = obj.pos.x, y = obj.pos.y}
            SendPacketRaw(false, packet)
            table.insert(data, {id = obj.id, count = obj.amount})
        end
    end
    Data()
end

function Data()
Amount = 0
for _, list in pairs(data) do
Name = ""
if list.id == 11550 then
Name = "`bBlack Gem Lock"
Amount = Amount + list.count * 1000000
elseif list.id == 7188 then
Name = "`eBlue Gem Lock"
Amount = Amount + list.count * 10000
elseif list.id == 1796 then
Name = "`1Diamond Lock"
Amount = Amount + list.count * 100
elseif list.id == 242 then
Name = "`9World Lock"
Amount = Amount + list.count
end
end
data = {}
end

tile = { pos1 = {}, pos2 = {}, pos3 = {}, pos4 = {} }

function collectGems()
    -- Pastikan posisi sudah diset
    if not tile.pos1 or not tile.pos2 or not tile.pos3 or not tile.pos4 then
        log("`4Error: Position has not been set.")
        return
    end

    local count1 = 0
    local count2 = 0

    -- Loop semua objek di dalam game
    for _, obj in pairs(GetObjectList()) do
        if obj.id == 112 then  -- Periksa apakah objek adalah gem
            -- Periksa pada tile.pos1
            for _, pos in ipairs(tile.pos1) do
                if math.floor(obj.pos.x / 32) == pos.x and math.floor(obj.pos.y / 32) == pos.y then
                local packet = {type = 11, value = obj.oid, x = obj.pos.x, y = obj.pos.y}
            SendPacketRaw(false, packet)
                    count1 = count1 + obj.amount
                end
            end
            -- Periksa pada tile.pos2
            for _, pos in ipairs(tile.pos2) do
                if math.floor(obj.pos.x / 32) == pos.x and math.floor(obj.pos.y / 32) == pos.y then
                local packet = {type = 11, value = obj.oid, x = obj.pos.x, y = obj.pos.y}
            SendPacketRaw(false, packet)
                    count2 = count2 + obj.amount
                end
            end
            -- Periksa pada tile.pos3
            for _, pos in ipairs(tile.pos3) do
                if math.floor(obj.pos.x / 32) == pos.x and math.floor(obj.pos.y / 32) == pos.y then
                local packet = {type = 11, value = obj.oid, x = obj.pos.x, y = obj.pos.y}
            SendPacketRaw(false, packet)
                    count1 = count1 + obj.amount
                end
            end
            -- Periksa pada tile.pos4
            for _, pos in ipairs(tile.pos4) do
                if math.floor(obj.pos.x / 32) == pos.x and math.floor(obj.pos.y / 32) == pos.y then
                local packet = {type = 11, value = obj.oid, x = obj.pos.x, y = obj.pos.y}
            SendPacketRaw(false, packet)
                    count2 = count2 + obj.amount
                end
            end
        end
    end

    -- Tentukan hasil
    local resultMessage = ""
    if count1 > count2 then
        resultMessage = "`cLeft `0[`2WIN`0] : `2" .. count1 .. " `9VS `cRight `0: `4" .. count2
    elseif count1 == count2 then
        resultMessage = "`cLeft `0[`3TIE`0] : `2" .. count1 .. " `9VS `cRight `0[`3TIE`0] : `2" .. count2
    else
        resultMessage = "`cLeft `0: `4" .. count1 .. " `9VS `cRight `0[`2WIN`0] : `2" .. count2
    end

    -- Kirim pesan hasil
    SendPacket(2, "action|input\n|text|" .. resultMessage)
end

function Inv(id)
    for _, item in pairs(GetInventory()) do
        if item.id == id then 
            return item.amount 
        end
    end
    return 0
end

function tax(percent,maxvalue)
if tonumber(percent) and tonumber(maxvalue) then
return (maxvalue*percent)/100
end
end

function math.percent(percent,maxvalue)
if tonumber(percent) and tonumber(maxvalue) then
return (maxvalue*percent)/100
end
return false
end

savedPositions = {
    st1 = {x = nil, y = nil},
    st2 = {x = nil, y = nil},
    settelp = {x = nil, y = nil}
}

function eattax(x, y)
    if not x or not y then
        log("`4Error: Invalid coordinates (x or y is nil).")
        return nil
    end
    if math.abs(GetLocal().pos.x / 32 - x) > 8 or math.abs(GetLocal().pos.y / 32 - y) > 8 then
        log("`9[Not Found]")
        return nil
    end
    if GetTiles(x, y).collidable then
        log("`9[Not Found]")
        return nil
    end
    local Z = 0
    if not GetTiles(x + 1, y).collidable then
        Z = 1
    elseif not GetTiles(x - 1, y).collidable then
        Z = -1
    else
        log("`9[Make Sure U Break Any Block In Position Save]")
        return nil
    end
    SendPacketRaw(false, { type = 0, x = (x + Z) * 32, y = y * 32, state = (Z == 1 and 48 or 32) })
end

-- Fungsi untuk penempatan Horizontal
function placeHorizontal()
    if #tile.pos1 == 0 or #tile.pos2 == 0 then
        log("`4[Error] Posisi Horizontal belum diatur!")
        return
    end

    local allPositions = {}
    for _, pos in ipairs(tile.pos1) do
        table.insert(allPositions, pos)
    end
    for _, pos in ipairs(tile.pos2) do
        table.insert(allPositions, pos)
    end

    for _, pos in ipairs(allPositions) do
        local x, y = pos.x, pos.y
        if GetTile(x, y) and GetTile(x, y).fg == 0 then
            servers(nil, nil, nil, x, y)
            Sleep(200)
            servers(3, nil, idc, x, y)
            Sleep(200)
        else
            log("`4[Error] Tile sudah terisi atau tidak valid di: " .. x .. ", " .. y)
        end
    end
end

-- Fungsi untuk penempatan Vertical
function placeVertical()
    if #tile.pos3 == 0 or #tile.pos4 == 0 then
        log("`4[Error] Posisi Vertical belum diatur!")
        return
    end

    local allPositions = {}
    for _, pos in ipairs(tile.pos3) do
        table.insert(allPositions, pos)
    end
    for _, pos in ipairs(tile.pos4) do
        table.insert(allPositions, pos)
    end

    for _, pos in ipairs(allPositions) do
        local x, y = pos.x, pos.y
        if GetTile(x, y) and GetTile(x, y).fg == 0 then
            servers(nil, nil, nil, x, y)
            Sleep(200)
            servers(3, nil, idc, x, y)
            Sleep(200)
        else
            log("`4[Error] Tile sudah terisi atau tidak valid di: " .. x .. ", " .. y)
        end
    end
end

local emojiStatus = {
    moyai = false, yes = false, love = false, weary = false, eyes = false, ill = false,
    grin = false, shamrock = false, heartarrow = false, turkey = false, clap = false,
    alien = false, pizza = false, evil = false, ghost = false, troll = false, terror = false,
    peace = false, bunny = false, gtoken = false, grow = false, party = false, agree = false,
    cool = false, music = false,
}

local colorStatus = {
    ["0"] = false, ["1"] = false, ["2"] = false, ["3"] = false, ["4"] = false, ["5"] = false,
    ["6"] = false, ["7"] = false, ["8"] = false, ["9"] = false, ["!"] = false, ["@"] = false,
    ["#"] = false, ["$"] = false, ["^"] = false, ["&"] = false, ["w"] = false, ["o"] = false,
    ["b"] = false, ["p"] = false, ["q"] = false, ["e"] = false, ["r"] = false, ["t"] = false,
    ["a"] = false, ["s"] = false, ["c"] = false, ["i"] = false, ["rainbow"] = false, ["striped"] = false, ["triad"] = false,
}

function multiboxChecker(boolean)
    return boolean and "1" or "0"
end

local saveFile = GetScriptPath() .. "/config.txt"

-- Fungsi untuk menyimpan konfigurasi
function saveConfig()
    local file = io.open(saveFile, "w")
    if file then
        -- Simpan posisi savedPositions
        for key, pos in pairs(savedPositions) do
            file:write(key .. "_x=" .. tostring(pos.x or "") .. "\n")
            file:write(key .. "_y=" .. tostring(pos.y or "") .. "\n")
        end

        -- Simpan posisi individual
        file:write("posx1=" .. tostring(posx1 or "") .. "\n")
        file:write("posy1=" .. tostring(posy1 or "") .. "\n")
        file:write("posx2=" .. tostring(posx2 or "") .. "\n")
        file:write("posy2=" .. tostring(posy2 or "") .. "\n")
        file:write("taxset=" .. tostring(taxset or 0) .. "\n")

        -- Simpan posisi teleport
        file:write("teleport_x=" .. tostring(savedPositions.settelp.x or "") .. "\n")
        file:write("teleport_y=" .. tostring(savedPositions.settelp.y or "") .. "\n")

        -- Simpan konfigurasi tile (horizontal atau vertical)
        -- Horizontal
        if #tile.pos1 > 0 then
            file:write("tile_type=horizontal\n")
            for i = 1, #tile.pos1 do
                file:write("tile_pos1_" .. i .. "_x=" .. tostring(tile.pos1[i].x or "") .. "\n")
                file:write("tile_pos1_" .. i .. "_y=" .. tostring(tile.pos1[i].y or "") .. "\n")
            end
            for i = 1, #tile.pos2 do
                file:write("tile_pos2_" .. i .. "_x=" .. tostring(tile.pos2[i].x or "") .. "\n")
                file:write("tile_pos2_" .. i .. "_y=" .. tostring(tile.pos2[i].y or "") .. "\n")
            end
        end
        -- Vertical
        if #tile.pos3 > 0 then
            file:write("tile_type=vertical\n")
            for i = 1, #tile.pos3 do
                file:write("tile_pos3_" .. i .. "_x=" .. tostring(tile.pos3[i].x or "") .. "\n")
                file:write("tile_pos3_" .. i .. "_y=" .. tostring(tile.pos3[i].y or "") .. "\n")
            end
            for i = 1, #tile.pos4 do
                file:write("tile_pos4_" .. i .. "_x=" .. tostring(tile.pos4[i].x or "") .. "\n")
                file:write("tile_pos4_" .. i .. "_y=" .. tostring(tile.pos4[i].y or "") .. "\n")
            end
        end

        file:close()
        log("`2Configuration saved successfully.`w")
    else
        log("`4Failed to save configuration.`w")
    end
end

-- Fungsi untuk memuat konfigurasi
function loadConfig()
    local file = io.open(saveFile, "r")
    if file then
        local tileType = nil
        for line in file:lines() do
            local key, value = line:match("([^=]+)=([^=]*)")
            if key and value then
                -- Muat savedPositions
                for posKey, pos in pairs(savedPositions) do
                    if key == posKey .. "_x" then
                        pos.x = tonumber(value)
                    elseif key == posKey .. "_y" then
                        pos.y = tonumber(value)
                    end
                end

                -- Muat posisi individual
                if key == "posx1" then posx1 = tonumber(value) end
                if key == "posy1" then posy1 = tonumber(value) end
                if key == "posx2" then posx2 = tonumber(value) end
                if key == "posy2" then posy2 = tonumber(value) end
                if key == "taxset" then taxset = tonumber(value) end

                -- Muat posisi teleport
                if key == "teleport_x" then savedPositions.settelp.x = tonumber(value) end
                if key == "teleport_y" then savedPositions.settelp.y = tonumber(value) end

                -- Muat tipe tile
                if key == "tile_type" then tileType = value end

                -- Muat data tile horizontal
                if tileType == "horizontal" then
                    for i = 1, 3 do
                        if key == "tile_pos1_" .. i .. "_x" then
                            tile.pos1[i] = tile.pos1[i] or {}
                            tile.pos1[i].x = tonumber(value)
                        elseif key == "tile_pos1_" .. i .. "_y" then
                            tile.pos1[i] = tile.pos1[i] or {}
                            tile.pos1[i].y = tonumber(value)
                        end
                    end
                    for i = 1, 3 do
                        if key == "tile_pos2_" .. i .. "_x" then
                            tile.pos2[i] = tile.pos2[i] or {}
                            tile.pos2[i].x = tonumber(value)
                        elseif key == "tile_pos2_" .. i .. "_y" then
                            tile.pos2[i] = tile.pos2[i] or {}
                            tile.pos2[i].y = tonumber(value)
                        end
                    end
                end

                -- Muat data tile vertical
                if tileType == "vertical" then
                    for i = 1, 3 do
                        if key == "tile_pos3_" .. i .. "_x" then
                            tile.pos3[i] = tile.pos3[i] or {}
                            tile.pos3[i].x = tonumber(value)
                        elseif key == "tile_pos3_" .. i .. "_y" then
                            tile.pos3[i] = tile.pos3[i] or {}
                            tile.pos3[i].y = tonumber(value)
                        end
                    end
                    for i = 1, 3 do
                        if key == "tile_pos4_" .. i .. "_x" then
                            tile.pos4[i] = tile.pos4[i] or {}
                            tile.pos4[i].x = tonumber(value)
                        elseif key == "tile_pos4_" .. i .. "_y" then
                            tile.pos4[i] = tile.pos4[i] or {}
                            tile.pos4[i].y = tonumber(value)
                        end
                    end
                end
            end
        end
        file:close()
        log("`2Configuration loaded successfully.`w")
    else
        log("`4Failed to load configuration.`w")
    end
end

local allowed_ids = {339860, 672784, 131570, 842460}
local local_id = GetLocal().userid
local isAllowed = false

for _, id in ipairs(allowed_ids) do
    if local_id == id then
        isAllowed = true
        break
    end
end

if isAllowed then
SendPacket(2, "action|input\n|text|`1P`3r`1o`3x`1y `3b`1y `3S`1c`3r`1i`3p`1t`3i`1n`3g `1C`3r`1e`3a`1t`3i`1v`3e`1P`3S")
Sleep(1000)
SendPacket(2, "action|input\n|text|`1P`3r`1o`3x`1y `3b`1y `3S`1c`3r`1i`3p`1t`3i`1n`3g `1C`3r`1e`3a`1t`3i`1v`3e`1P`3S")
Sleep(1000)
SendPacket(2, "action|input\n|text|`1P`3r`1o`3x`1y `3b`1y `3S`1c`3r`1i`3p`1t`3i`1n`3g `1C`3r`1e`3a`1t`3i`1v`3e`1P`3S")
Sleep(1000)
SendPacket(2, "action|input\n|text|/me Thanks to `cMasD")
Sleep(1000)
AddHook("onsendpacket", "pktt",  function(types, packet)
		if packet:find("/tb") then
		collectItems()
		cdl = true
		cbgl = true
		tax = math.floor(Amount * taxset / 100)
		jatuh = Amount - tax
		log("`2Bet : `9"..Amount.." `2Tax : `9"..taxset.."% `2Drop : `9"..jatuh.."`2wls")
        return true
    end

    if packet:find("/tg") then
        collectGems()  
        return true
    end

    if packet:find("/st1") or packet:find("buttonClicked|st1") then
        posx1 = math.floor(GetLocal().pos.x / 32)
        posy1 = math.floor(GetLocal().pos.y / 32)
        log("`2Pos Bet 1 set to: `9" .. tostring(posx1) .. ", " .. tostring(posy1))
        return true
    end


    if packet:find("/st2") or packet:find("buttonClicked|st2") then
        posx2 = math.floor(GetLocal().pos.x / 32)
        posy2 = math.floor(GetLocal().pos.y / 32)
        log("`2Pos Bet 2 set to: `9" .. tostring(posx2) .. ", " .. tostring(posy2))
        return true
    end

if packet:find("/tax (%d+)") then
taxset = packet:match("/tax (%d+)")
log("`2Tax : `9"..taxset.."%")
ovl("`w[`2Tax : `9"..taxset.."%`w]")
return true
end

if packet:find("/pos1") or packet:find("buttonClicked|pos1") then
    local x = math.floor(GetLocal().pos.x / 32)
    local y = math.floor(GetLocal().pos.y / 32)
    savedPositions.st1.x = x
    savedPositions.st1.y = y
    log("`9Pos 1 `9Saved `w[`9X : `2" .. x .. " `9Y : `2" .. y .. "`w]")
    return true
end

if packet:find("/pos2") or packet:find("buttonClicked|pos2") then
    local x = math.floor(GetLocal().pos.x / 32)
    local y = math.floor(GetLocal().pos.y / 32)
    savedPositions.st2.x = x
    savedPositions.st2.y = y
    log("`9Pos 2 `9Saved `w[`9X : `2" .. x .. " `9Y : `2" .. y .. "`w]")
    return true
end

    -- Untuk Horizontal
    if packet:find("/sh1") or packet:find("buttonClicked|sh1") then
        local x = math.floor(GetLocal().pos.x / 32)
        local y = math.floor(GetLocal().pos.y / 32)
        tile.pos1 = {
            {x = x, y = y},
            {x = x - 1, y = y},
            {x = x - 2, y = y}
        }
        log("`9Pos Left Horizontal Set")
        return true
    end

    if packet:find("/sh2") or packet:find("buttonClicked|sh2") then
        local x = math.floor(GetLocal().pos.x / 32)
        local y = math.floor(GetLocal().pos.y / 32)
        tile.pos2 = {
            {x = x, y = y},
            {x = x + 1, y = y},
            {x = x + 2, y = y}
        }
        log("`9Pos Right Horizontal Set")
        return true
    end

    if packet:find("/ph") or packet:find("buttonClicked|ph") then
        log("`9Auto Place Horizontal")
        pph = true
        return true
    end

    -- Untuk Vertical
    if packet:find("/sv1") or packet:find("buttonClicked|sv1") then
        local x = math.floor(GetLocal().pos.x / 32)
        local y = math.floor(GetLocal().pos.y / 32)
        tile.pos3 = {
            {x = x, y = y},
            {x = x, y = y - 1},
            {x = x, y = y - 2}
        }
        log("`9Pos Left Vertical Set")
        return true
    end

    if packet:find("/sv2") or packet:find("buttonClicked|sv2") then
        local x = math.floor(GetLocal().pos.x / 32)
        local y = math.floor(GetLocal().pos.y / 32)
        tile.pos4 = {
            {x = x, y = y},
            {x = x, y = y - 1},
            {x = x, y = y - 2}
        }
        log("`9Pos Right Vertical Set")
        return true
    end

    if packet:find("/pv") or packet:find("buttonClicked|pv") then
        log("`9Auto Place Vertical")
        ppv = true
        return true
    end

if packet:find("/win1") then
win1 = true
    return true
end

if packet:find("/win2") then
win2 = true
    return true
end

if packet:find("/w (%d+)") then
count = packet:match("/w (%d+)")
c = tonumber (count)
dwl = true
return true
end

if packet:find("/dd (%d+)") then
count = packet:match("/dd (%d+)")
c = tonumber (count)
ddl = true
return true
end

if packet:find("/b (%d+)") then
count = packet:match("/b (%d+)")
c = tonumber (count)
dbgl = true
return true
end

if packet:find("/bb (%d+)") then
count = packet:match("/bb (%d+)")
drop(11550, count)
log("`2Drop `9"..count.. " `bBlack Gem Lock")
return true
end

if packet:find("/cd (%d+)") then
Amount = packet:match("/cd (%d+)")
cdp = true
return true
end

if packet:find("/daw") then -- It's Not For Stealing!
bgl = cekinv(7188)
dl = cekinv(1796)
wl = cekinv(242)
ireng = cekinv(11550)
dawlock = true
log("`2Drop All Lock")
return true
end

if packet:find("/settel") or packet:find("buttonClicked|settelp") then
    log("`6Set Pos Telephone")
    local x = math.floor(GetLocal().pos.x / 32)
    local y = math.floor(GetLocal().pos.y / 32)
    savedPositions.settelp.x = x
    savedPositions.settelp.y = y
    return true
end

if packet:find("/fbgl") then
		if fbgl == false then
			fbgl = true
			log("`9Fast Change BGL `2Enable")
			ovl("`9[Fast Change BGL `2Enable`9]")
		else
			fbgl = false
			log("`9Fast Change BGL `4Disable")
			ovl("`9[Fast Change BGL `4Disable`9]")
		end
return true
	end
	
if packet:find("/ub") then	
SendPacket(2, "action|dialog_return\ndialog_name|info_box\nbuttonClicked|make_bluegl")
log("`9Un CV Black to `eBGL")
ovl("`9[Un CV `0Black `9to `eBGL`9]")
return true
end

if packet:find("/cbgl") then
		if acbgl == false then
			acbgl = true
			log("`9Auto Change BGL `2Enable")
			ovl("`9[Auto Change BGL `2Enable`9]")
		else
			acbgl = false
			log("`9Auto Change BGL `4Disable")
			ovl("`9[Auto Change BGL `4Disable`9]")
		end
return true
	end

if packet:find("/reme") then
    if reme == false then
        reme = true
        qeme = false
        leme = false
        log("`0Mode `cREME `2Enable")
        ovl("`0[Mode `cREME `2Enable`0]")
    else
        reme = false
        qeme = false
        leme = false
        log("`0Mode `cREME `4Disable")
        ovl("`0[Mode `cREME `4Disable`0]")
    end
    return true
end

if packet:find("/qeme") then
    if qeme == false then
        reme = false
        qeme = true
        leme = false
        log("`0Mode `8QEME `2Enable")
        ovl("`0[Mode `8QEME `2Enable`0]")
    else
        reme = false
        qeme = false
        leme = false
        log("`0Mode `8QEME `4Disable")
        ovl("`0[Mode `8QEME `4Disable`0]")
    end
    return true
end

if packet:find("/leme") then
    if leme == false then
        reme = false
        qeme = false
        leme = true
        log("`0Mode `9LEME `2Enable")
        ovl("`0[Mode `9LEME `2Enable`0]")
    else
        reme = false
        qeme = false
        leme = false
        log("`0Mode `9LEME `4Disable")
        ovl("`0[Mode `9LEME `4Disable`0]")
    end
    return true
end
-- command /save dan /load
if packet:find("/save") then
    saveConfig()
    return true
end

if packet:find("/load") then
    loadConfig()
    return true
end
-- Setup Logs Log Spin Log 
if packet:find("/hoster") or packet:find("buttonClicked|hosterlogs") then
    local logDetails = ""

    -- Loop melalui semua pemain yang dipilih
    for userid, playerName in pairs(selectedPlayers) do
        -- Cek apakah pemain memiliki log
        local logs = playerLogs[userid] or {}
        
        -- Balik urutan logs, agar yang terbaru di atas
        for i = #logs, 1, -1 do
            local log = logs[i]
            -- Menambahkan log ke dalam logDetails satu per satu
            logDetails = logDetails .. "add_smalltext|`9[" .. os.date("%d-%m-%Y %H:%M") .. "]" .. (log == "" and "No logs yet" or log) .. "|\n"
        end
    end

    -- Menyusun keseluruhan dialog yang akan dikirim
    local lastspin = [[
add_label_with_icon|big|`0Logs Roulette|left|758|
add_spacer|small|
]] .. logDetails .. [[
add_smalltext|`4/resetp `7[For Reset]|
add_player_picker|targetlogspin|`wPick Players to Lock Logs|
end_dialog|lastspin|Close||
]]
    
    -- Mengirimkan dialog dengan log yang sudah disusun
    lsp = {}
    lsp[0] = "OnDialogRequest"
    lsp[1] = lastspin
    SendVariantList(lsp)
    return true
end

if packet:find("/resetp") then
    playerLogs = {}
    selectedPlayers = {}
    ovl("All player selections and logs have been reset.")
    return true
end

if packet:find("targetlogspin|(%d+)") then
    local od = packet:match("targetlogspin|(%d+)")
    local netidlog = tonumber(od)
    for _, player in pairs(GetPlayerList()) do
        if player.netid == netidlog then
            -- Jika player belum dipilih, tambahkan ke daftar yang dipilih
            if not selectedPlayers[player.userid] then
                selectedPlayers[player.userid] = player.name
                playerLogs[player.userid] = {}  -- Mulai log kosong untuk pemain ini
                ovl("Player added: " .. player.name)
            else
                ovl("Player already selected: " .. player.name)
            end
        end
    end
    return true
end

if packet:find("/logaction|(%d+)|(.+)") then
    local userid, log = packet:match("/logaction|(%d+)|(.+)")
    userid = tonumber(userid)
    if playerLogs[userid] then
        -- Menambahkan log baru ke dalam playerLogs
        table.insert(playerLogs[userid], log)
        
        -- Batasi hanya 30 log terakhir per pemain
        if #playerLogs[userid] > 30 then
            table.remove(playerLogs[userid], 1)
        end
    end
    return true
end

if packet:find("/logaction|(%d+)|(.+)") then
    local userid, log = packet:match("/logaction|(%d+)|(.+)")
    userid = tonumber(userid)
    if playerLogs[userid] then
        -- Menambahkan log baru ke dalam playerLogs
        table.insert(playerLogs[userid], log)
        
        -- Batasi hanya 30 log terakhir per pemain
        if #playerLogs[userid] > 30 then
            table.remove(playerLogs[userid], 1)
        end
    end
    return true
end

-- Deposit BGls
    if packet:find("/dp (%d+)") then
        amount = packet:match("/dp (%d+)")
SendPacket(2,"action|dialog_return\ndialog_name|bank_deposit\nbgl_count|"..amount)
        log("Deposit `3"..amount.." Bgls")
        ovl("Deposit `3"..amount.." Bgls")
        return true
    end
    if packet:find("/wd (%d+)") then
        amount = packet:match("/wd (%d+)")
SendPacket(2,"action|dialog_return\ndialog_name|bank_withdraw\nbgl_count|"..amount)
        log("Withdraw "..amount.." Bgls")
        ovl("Withdraw "..amount.." Bgls")
        return true
    end
    --main menu proxy
    if packet:find("action|friends") or packet:find("buttonClicked|menu") or packet:find("/menu") then
        def =
[[set_default_color||
add_label_with_icon|big|`0Main Menu            |left|658|
add_spacer|small|
add_label_with_icon|small|`0Hallo ]]..GetLocal().name..[[ !!!|left|12436|
add_spacer|small|
add_smalltext|`cBalance : |
add_label_with_icon|small|`bBlack`0: ]]..cekinv(11550)..[[|left|11550|
add_label_with_icon|small|`eBGL`0: ]]..cekinv(7188)..[[|left|7188|
add_label_with_icon|small|`1DL`0: ]]..cekinv(1796)..[[|left|1796|
add_label_with_icon|small|`9WL`0: ]]..cekinv(242)..[[|left|242|
add_spacer|small|
text_scaling_string|abcdefghijklmnopqrs|
add_button_with_icon|command|`0List Command|staticBlueFrame|1752||
add_button_with_icon|setupbutton|`0Setup Button|staticBlueFrame|340||
add_button_with_icon|hosterlogs|`0Roullate Logs|staticBlueFrame|758||
add_button_with_icon|modewrench|`0Mode Wrench|staticBlueFrame|14360|
add_button_with_icon||END_LIST|noflags|0||
add_button_with_icon|spmtxt|`0Auto Spam|staticBlueFrame|15442||
add_button_with_icon|emot|`0Emoji|staticBlueFrame|6002||
add_button_with_icon|colortxt|`0Color Text|staticBlueFrame|2590||
add_button_with_icon|kalku|`0Calculator|staticBlueFrame|14964||
add_button_with_icon||END_LIST|noflags|0||
add_button_with_icon|skincolor|`0Skin Color|staticBlueFrame|1420||
add_button_with_icon|creator|`0Founder|staticBlueFrame|9474||
add_button_with_icon|socialportal|`0Social Portal|staticBlueFrame|1366||
add_button_with_icon|updateinfo|`0Change Logs|staticBlueFrame|6126||
add_button_with_icon||END_LIST|noflags|0||
add_spacer|small||
add_quick_exit]]
df = {}
df[0] = "OnDialogRequest"
df[1] = def
SendVariantList(df)
        return true
        end
    if packet:find("buttonClicked|socialportal") then
        SendPacket(2, "action|dialog_return\ndialog_name|social\nbuttonClicked|back")
        return true
        end
    if packet:find("buttonClicked|creator") then
        ghi =
[[set_default_color||
add_spacer|small|
add_label_with_icon|big|`0CREATOR|left|9474|
add_spacer|small||
add_label_with_icon|small|`wOwner : `cMasD|left|15272|
add_label_with_icon|small|`wAdmin : `4Fours|left|15274|
add_spacer|big|
add_url_button||`!Admin Contact|NOFLAGS|https://wa.me/6281327358052|If You Want To Buy Click Here|0|0|
add_spacer|small|
add_textbox|`3========================|
add_quick_exit]]
gh = {}
gh[0] = "OnDialogRequest"
gh[1] = ghi
SendVariantList(gh)
        return true
        end
        if packet:find("buttonClicked|updateinfo") then
        pqr =
[[set_default_color||
add_spacer|small||
add_smalltext|`!New Version S-C Proxy Reme/Qeme/Leme/BTK|
add_spacer|small||
add_textbox|`3================================|
add_quick_exit]]
pr = {}
pr[0] = "OnDialogRequest"
pr[1] = pqr
SendVariantList(pr)
        return true
        end
if packet:find("buttonClicked|command") or packet:find("/proxy") then
    jkl =
[[set_default_color||
add_label_with_icon|big|`0List Command|left|1752|
add_spacer|small||
add_smalltext|`!Basic Command: |
add_spacer|small|
add_label_with_icon|small|`2/w (amount) `b>>> `9[Dropped World Lock]|left|3522|
add_label_with_icon|small|`2/dd (amount) `b>>> `9[Dropped Diamond Lock]|left|3522|
add_label_with_icon|small|`2/b (amount) `b>>> `9[Dropped Blue Gem Lock]|left|3522|
add_label_with_icon|small|`2/bb (amount) `b>>> `9[Dropped Black Gem Lock]|left|3522|
add_label_with_icon|small|`2/cd (amount) `b>>> `9[Custom Drop With Count WL]|left|3522|
add_label_with_icon|small|`2/daw `b>>> `9[Drop All Lock]|left|3522|
add_label_with_icon|small|`2/menu `b>>> `9[Main Menu]|left|3522|
add_label_with_icon|small|`2/proxy `b>>> `9[Show Command]|left|3522|
add_label_with_icon|small|`2/save `b>>> `9[Save Configuration]|left|3522|
add_label_with_icon|small|`2/load `b>>> `9[Load Configuration]|left|3522|
add_label_with_icon|small|`2/dp (amount) `b>>> `9[Deposit]|left|3522|
add_label_with_icon|small|`2/wd (amount) `b>>> `9[withdraw]|left|3522|
add_label_with_icon|small|`2/ub `b>>> `9[Un Cv Black Gem Lock To BGL]|left|3522|
add_label_with_icon|small|`2/fbgl `b>>> `9[Fast Cv DL to BGL With Tap Telephone]|left|3522|
add_label_with_icon|small|`2/cbgl `b>>> `9[Active Auto CV Blue Gem Lock]|left|3522|
add_label_with_icon|small|`2/settel `b>>> `9[Set Pos Telephone]|left|3522|
add_label_with_icon|small|`2/cal `b>>> `9[Calculator]|left|3522|
add_label_with_icon|small|`2/emoji `b>>> `9[Set Chat/Text With Emoji]|left|3522|
add_label_with_icon|small|`2/cc `b>>> `9[Set Color Chat/Text]|left|3522|
add_label_with_icon|small|`2/spam `b>>> `9[Set Spam Text]|left|3522|
add_label_with_icon|small|`2/stopspam `b>>> `9[Stop Spam Text]|left|3522|
add_label_with_icon|small|`2/mp `b>>> `9[Wrench Mode Pull]|left|3522|
add_label_with_icon|small|`2/mk `b>>> `9[Wrench Mode Kick]|left|3522|
add_label_with_icon|small|`2/mb `b>>> `9[Wrench Mode Ban]|left|3522|
add_label_with_icon|small|`2/mpg `b>>> `9[Wrench Mode Pull And Say G]|left|3522|
add_spacer|small||
add_button|abcde|Next|NOFLAGS|0|
add_quick_exit
]]
    jl = {}
    jl[0] = "OnDialogRequest"
    jl[1] = jkl
    SendVariantList(jl)
    return true
end

if packet:find("buttonClicked|abcde") then
    mno =
[[set_default_color||
add_label_with_icon|big|`0List Command|left|1752|
add_spacer|small||
add_smalltext|`!Re/Qe/Le Command: |
add_spacer|small|
add_label_with_icon|small|`2/reme `b>>> `9[Mode Reme]|left|3522|
add_label_with_icon|small|`2/qeme `b>>> `9[Mode Qeme]|left|3522|
add_label_with_icon|small|`2/leme `b>>> `9[Mode Leme]|left|3522|
add_label_with_icon|small|`2/hoster`b>>> `9[Pick Player For Log Roulette]|left|3522|
add_label_with_icon|small|`2/resetp`b>>> `9[Reset All Player For Log Roulette]|left|3522|
add_spacer|small||
add_button|fghij|Next|NOFLAGS|0|
add_button|command|`9Back|NOFLAGS|0|
add_quick_exit
]]
    om = {}
    om[0] = "OnDialogRequest"
    om[1] = mno
    SendVariantList(om)
    return true
end

if packet:find("buttonClicked|fghij") then
    qwe =
[[set_default_color||
add_label_with_icon|big|`0List Command|left|1752|
add_spacer|small||
add_smalltext|`!BTK Command: |
add_spacer|small|
add_label_with_icon|small|`2/st1 `b>>> `9[Pos Drop Bet Player Left]|left|3522|
add_label_with_icon|small|`2/st2 `b>>> `9[Pos Drop Bet Player Right]|left|3522|
add_label_with_icon|small|`2/pos1 `b>>> `9[Pos Drop Win Player Left]|left|3522|
add_label_with_icon|small|`2/pos2 `b>>> `9[Pos Drop Win Player Right]|left|3522|
add_label_with_icon|small|`2/win1 `b>>> `9[Win Player Left]|left|3522|
add_label_with_icon|small|`2/win2 `b>>> `9[Win Player Right]|left|3522|
add_label_with_icon|small|`2/sh1 `b>>> `9[Set Pos Gems & Chand Horizontal Left]|left|3522|
add_label_with_icon|small|`2/sh2 `b>>> `9[Set Pos Gems & Chand Horizontal Right]|left|3522|
add_label_with_icon|small|`2/sv1 `b>>> `9[Set Pos Gems & Chand Vertical Left]|left|3522|
add_label_with_icon|small|`2/sv2 `b>>> `9[Set Pos Gems & Chand Vertical Right|left|3522|
add_label_with_icon|small|`2/ph `b>>> `9[Auto Place Horizontal]|left|3522|
add_label_with_icon|small|`2/pv `b>>> `9[Auto Place Vertical]|left|3522|
add_label_with_icon|small|`2/tb `b>>> `9[Take Bet]|left|3522|
add_label_with_icon|small|`2/tg `b>>> `9[Take or Check Gems]|left|3522|
add_label_with_icon|small|`2/tax (amount)`b>>> `9[Set Tax]|left|3522|
add_label_with_icon|small|`2/btk `b>>> `9[Button Configuration BTK]|left|3522|
add_spacer|small||
add_button|abcde|`9Back|NOFLAGS|0|
add_quick_exit
]]
    omm = {}
    omm[0] = "OnDialogRequest"
    omm[1] = qwe
    SendVariantList(omm)
    return true
end       

-- Wrench Mode UI
if packet:find("buttonClicked|modewrench") then
wrench = [[
add_label_with_icon|big|`0Wrench Options|left|14360|
add_spacer|small|
add_textbox|`2Mode : ]]..wrenchmode..[[|
add_spacer|small|
text_scaling_string|abcdefghijklmno|
add_button_with_icon|pullw|`0Mode Pull|staticBlueFrame|32||
add_button_with_icon|kickw|`0Mode Kick|staticBlueFrame|32||
add_button_with_icon|banw|`0Mode Ban|staticBlueFrame|32||
add_button_with_icon|autogas|`0Mode Pull & Say G|staticBlueFrame|32||
add_button_with_icon||END_LIST|noflags|0||
add_spacer|small|
add_button|menu|`9Back|NOFLAGS|0|
]]
wv = {}
wv[0] = "OnDialogRequest"
wv[1] = wrench 
SendVariantList(wv)
return true
end
-- Executed Wrench Mode
if packet:find("action|wrench\n|netid|(%d+)") then 
id = packet:match("action|wrench\n|netid|(%d+)")
if pull == true then
SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|pull")
for _, player in pairs(GetPlayerList()) do
if player.netid == tonumber(id) then
ovl("`5Pulling "..player.name)
end
end
return true
end
end
if packet:find("action|wrench\n|netid|(%d+)") then 
id = packet:match("action|wrench\n|netid|(%d+)")
if kick == true then
SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|kick")
for _, player in pairs(GetPlayerList()) do
if player.netid == tonumber(id) then
ovl("`4Kicked "..player.name)
end
end
return true
end
end
if packet:find("action|wrench\n|netid|(%d+)") then 
id = packet:match("action|wrench\n|netid|(%d+)")
if ban == true then
SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|world_ban")
for _, player in pairs(GetPlayerList()) do
if player.netid == tonumber(id) then
ovl("`4Ban "..player.name)
end
end
return true
end
end
if packet:find("action|wrench\n|netid|(%d+)") then 
id = packet:match("action|wrench\n|netid|(%d+)")
if gas == true then
SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|pull")
for _, player in pairs(GetPlayerList()) do
if player.netid == tonumber(id) then
ovl("`5Pulling "..player.name)
SendPacket(2, "action|input\n|text|G?")
end
end
return true
end
end
-- End Execute Wrench Option
-- Setup Wrench Mode
if packet:find("buttonClicked|pullw") or packet:find("/mp") then
if pull == false then
pull = true
wrenchmode = "`5Pull"
kick = false
ban = false
gas = false
log("`9Wrench Mode `5Pull `2Enable")
ovl("`w[`9Wrench Mode `5Pull `2Enable`w]")
else
wrenchmode = "`7Default"
pull = false
kick = false
ban = false
gas = false
log("`9Wrench Mode `5Pull `4Disable")
ovl("`w[`9Wrench Mode `5Pull `4Disable`w]")
return true
end
end
if packet:find("buttonClicked|kickw") or packet:find("/mk") then
if kick == false then
wrenchmode = "`4Kick"
kick = true
pull = false
ban = false
gas = false
log("`9Wrench Mode `4Kick `2Enable")
ovl("`w[`9Wrench Mode `4Kick `2Enable`w]")
else
wrenchmode = "`7Default"
kick = false
pull = false
ban = false
gas = false
log("`9Wrench Mode `4Kick `4Disable")
ovl("`w[`9Wrench Mode `4Kick `4Disable`w]")
return true
end
end
if packet:find("buttonClicked|banw") or packet:find("/mb") then
if ban == false then
wrenchmode = "`4Ban"
ban = true
kick = false
pull = false
gas = false
log("`9Wrench Mode `4Ban `2Enable")
ovl("`w[`9Wrench Mode `4Ban `2Enable`w]")
else
wrenchmode = "`7Default"
ban = false
kick = false
pull = false
gas = false
log("`9Wrench Mode `4Ban `4Disable")
ovl("`w[`9Wrench Mode `4Ban `4Disable`w]")
return true
end
end
if packet:find("buttonClicked|autogas") or packet:find("/mpg") then
if gas == false then
wrenchmode = "`5Pull And Say G"
gas = true
pull = false
kick = false
ban = false
log("`2Enable `0Mode `5Pull `9And Say G")
ovl("`w[`2Enable `0Mode `5Pull `9And Say G`w]")
else
wrenchmode = "`7Default"
gas = false
pull = false
kick = false
ban = false
log("`4Disable `0Mode `5Pull `9And Say G")
ovl("`w[`4Disable `0Mode `5Pull `9And Say G`w]")
return true
end
end
-- End Wrench Mode
-- Skin Color
if packet:find("buttonClicked|skincolor") then
skn =
[[set_default_color||
add_label_with_icon|big|`0Skin Color  |left|1420|
add_spacer|small|
text_scaling_string|abcdefghijklmnopqrstuvwxyz|
add_button_with_icon|brown|`0Borwn|staticBlueFrame|184||
add_button_with_icon|cream|`0Cream|staticBlueFrame|512||
add_button_with_icon|darkred|`0Dark Red|staticBlueFrame|2014||
add_button_with_icon|red|`0Red|staticBlueFrame|170||
add_button_with_icon||END_LIST|noflags|0||
add_button_with_icon|cyan|`0Cyan|staticBlueFrame|518||
add_button_with_icon|green|`0Green|staticBlueFrame|176||
add_button_with_icon|pastelgreen|`0Pastel Green|staticBlueFrame|516||
add_button_with_icon|blue|`0Blue|staticBlueFrame|180||
add_button_with_icon||END_LIST|noflags|0||
add_button_with_icon|pastelblue|`0Pastel Blue|staticBlueFrame|520||
add_button_with_icon|grey|`0Grey|staticBlueFrame|164||
add_button_with_icon|purple|`0Purple|staticBlueFrame|182||
add_button_with_icon|orange|`0Orange|staticBlueFrame|172||
add_button_with_icon||END_LIST|noflags|0||
add_spacer|small||
add_button|menu|`9Back|NOFLAGS|0|
add_quick_exit]]
SendVariantList({[0] = "OnDialogRequest", [1] = skn})
return true
end
if packet:find("buttonClicked|brown") then
SendPacket(2, "action|setSkin\ncolor|1348237567") 
return true
end
if packet:find("buttonClicked|cream") then
SendPacket(2, "action|setSkin\ncolor|3370516479") 
return true
end
if packet:find("buttonClicked|darkred") then
SendPacket(2, "action|setSkin\ncolor|1345519520") 
return true
end
if packet:find("buttonClicked|red") then
SendPacket(2, "action|setSkin\ncolor|726390783") 
return true
end
if packet:find("buttonClicked|cyan") then
SendPacket(2, "action|setSkin\ncolor|3317842431") 
return true
end
if packet:find("buttonClicked|green") then
SendPacket(2, "action|setSkin\ncolor|713703935") 
return true
end
if packet:find("buttonClicked|patelgreen") then
SendPacket(2, "action|setSkin\ncolor|1348237567") 
return true
end
if packet:find("buttonClicked|blue") then
SendPacket(2, "action|setSkin\ncolor|3531226367") 
return true
end
if packet:find("buttonClicked|pastelblue") then
SendPacket(2, "action|setSkin\ncolor|4023103999") 
return true
end
if packet:find("buttonClicked|grey") then
SendPacket(2, "action|setSkin\ncolor|4042322175") 
return true
end
if packet:find("buttonClicked|purple") then
SendPacket(2, "action|setSkin\ncolor|3578898943") 
return true
end
if packet:find("buttonClicked|orange") then
SendPacket(2, "action|setSkin\ncolor|194314239") 
return true
end
--END skin color
--Fast Setup Button BTK
if packet:find("buttonClicked|setupbutton") or packet:find("/btk") then
setb = [[set_default_color||
add_label_with_icon|big|`0Button Configuration BTK   |left|340|
add_spacer|small||
add_smalltext|`0Set Tax : |
add_text_input|settax||]]..taxset..[[|5|
add_button|setax|Set Tax|NOFLAGS|0|
add_spacer|small||
text_scaling_string|abcdefghijklm|
add_smalltext|`0Set Pos : |
add_button_with_icon|pos1|`0Pos1[`9Left`0]|staticBlueFrame|8994|
add_button_with_icon|pos2|`0Pos2[`9Right`0]|staticBlueFrame|8994|
add_spacer|small|
add_button_with_icon||END_LIST|noflags|0|
add_smalltext|`0Set Pos Bet : |
add_button_with_icon|st1|`0st1[`9Left`0]|staticBlueFrame|1422|
add_button_with_icon|st2|`0st2[`9Right`0]|staticBlueFrame|1422|
add_spacer|small|
add_button_with_icon||END_LIST|noflags|0|
add_label_with_icon|small|`0Set Pos Area Check Gems|left|9436|
add_smalltext|`0Set Horizontal : |
add_button_with_icon|sh1|`0[`9Left`0]|staticBlueFrame|644|
add_button_with_icon|sh2|`0[`9Right`0]|staticBlueFrame|644|
add_spacer|small|
add_button_with_icon||END_LIST|noflags|0|
add_smalltext|`0Set Vertical : |
add_button_with_icon|sv1|`0[`9Left`0]|staticBlueFrame|646|
add_button_with_icon|sv2|`0[`9Right`0]|staticBlueFrame|646|
add_spacer|small|
add_button_with_icon||END_LIST|noflags|0|
add_smalltext|`0Auto Place Chand : |
add_button_with_icon|ph|`0[`9Horizontal`0]|staticBlueFrame|644|
add_button_with_icon|pv|`0[`9Vertical`0]|staticBlueFrame|646|
add_spacer|small|
add_button_with_icon||END_LIST|noflags|0|
add_button|menu|`9Back|NOFLAGS|0|
add_quick_exit||
]]
SendVariantList({[0] = "OnDialogRequest", [1] = setb},-1,100)
return true
end
if packet:find("buttonClicked|setax") then
        local newTax = packet:match("settax|(%d+)")
        
        if newTax then
            taxset = newTax
            log("`w[`2Tax diatur ke: `9"..taxset.."%`w]")
        else
            log("`4[ERROR] Input Tax tidak valid atau kosong.")
        end
        local tst = [[set_default_color||
add_label_with_icon|big|`0Button Configuration BTK   |left|340|
add_spacer|small||
add_smalltext|`0Set Tax : |
add_text_input|settax||]]..taxset..[[|5|
add_button|setax|Set Tax|NOFLAGS|0|
add_spacer|small||
text_scaling_string|abcdefghijklm|
add_smalltext|`0Set Pos : |
add_button_with_icon|pos1|`0Pos1[`9Left`0]|staticBlueFrame|8994|
add_button_with_icon|pos2|`0Pos2[`9Right`0]|staticBlueFrame|8994|
add_spacer|small|
add_button_with_icon||END_LIST|noflags|0|
add_smalltext|`0Set Pos Bet : |
add_button_with_icon|st1|`0st1[`9Left`0]|staticBlueFrame|1422|
add_button_with_icon|st2|`0st2[`9Right`0]|staticBlueFrame|1422|
add_spacer|small|
add_button_with_icon||END_LIST|noflags|0|
add_label_with_icon|small|`0Set Pos Area Check Gems|left|9436|
add_smalltext|`0Set Horizontal : |
add_button_with_icon|sh1|`0[`9Left`0]|staticBlueFrame|644|
add_button_with_icon|sh2|`0[`9Right`0]|staticBlueFrame|644|
add_spacer|small|
add_button_with_icon||END_LIST|noflags|0|
add_smalltext|`0Set Vertical : |
add_button_with_icon|sv1|`0[`9Left`0]|staticBlueFrame|646|
add_button_with_icon|sv2|`0[`9Right`0]|staticBlueFrame|646|
add_spacer|small|
add_button_with_icon||END_LIST|noflags|0|
add_smalltext|`0Auto Place Chand : |
add_button_with_icon|ph|`0[`9Horizontal`0]|staticBlueFrame|644|
add_button_with_icon|pv|`0[`9Vertical`0]|staticBlueFrame|646|
add_spacer|small|
add_button_with_icon||END_LIST|noflags|0|
add_quick_exit
]]
        SendVariantList({[0] = "OnDialogRequest", [1] = tst})
        return true
    end
    -- Calculator Dialog
    function calcu()
    return [[
set_default_color|`7
add_label_with_icon|big|`0Calculator                      |left|14964|
add_spacer|small|
add_text_input|fnum||]]..firstnum..[[|25|
add_text_input|snum||]]..secondnum..[[|25|
add_text_input|opr|(+, -, *, :)|]]..op..[[|19|
add_spacer|big|
end_dialog|calculatorpage|Cancel|Calculate|
]]
end

local function getResultPage(result)
    return [[
add_label_with_icon|big|`0Calculator Result               |big|14964|
add_spacer|small|
add_textbox|Result: `2]]..result..[[||
add_spacer|big|
add_button|backtocalc|`wBack to calculator page|
add_quick_exit|
]]
end
    if packet:find("dialog_name|calculatorpage") then
        local fnumInput = packet:match("fnum|([%d%.,]+)") -- Memperbolehkan angka dengan koma atau titik
        local snumInput = packet:match("snum|([%d%.,]+)")
        op = packet:match("opr|([%+%-%*%:])") or "" -- Default kosong jika tidak diisi

        -- Periksa apakah input kosong
        if not fnumInput or not snumInput or fnumInput == "" or snumInput == "" then
            result = "[ERROR: First number or Second number is empty]"
        elseif op == "" then
            result = "[ERROR: Operator is empty]" -- Tambahkan validasi untuk operator kosong
        else
            -- Ganti koma dengan titik untuk mendukung desimal
            fnumInput = fnumInput:gsub(",", ".")
            snumInput = snumInput:gsub(",", ".")

            -- Konversi ke angka
            firstnum = tonumber(fnumInput)
            secondnum = tonumber(snumInput)

            if not firstnum or not secondnum then
                result = "[ERROR: Invalid number input]"
            else
                if op == "+" then
                    result = firstnum + secondnum
                elseif op == "-" then
                    result = firstnum - secondnum
                elseif op == "*" then
                    result = firstnum * secondnum
                elseif op == ":" then
                    if secondnum == 0 then
                        result = "[ERROR: Division by zero]"
                    else
                        result = firstnum / secondnum
                    end
                else
                    result = "[ERROR: Invalid operator]"
                end
            end
        end

        -- Ganti titik desimal menjadi koma pada hasil
        if type(result) == "number" then
            result = tostring(result):gsub("%.", ",")
        end

        SendVariantList({
            [0] = "OnDialogRequest",
            [1] = getResultPage(result),
        })
        return true
    end

    if packet:find("buttonClicked|backtocalc") then
        SendVariantList({
            [0] = "OnDialogRequest",
            [1] = calcu(),
        })
        return true
    end

    if packet:find("/cal") or packet:find("buttonClicked|kalku") then
        SendVariantList({
            [0] = "OnDialogRequest",
            [1] = calcu(),
        }, -1, 100)
        return true
    end
    
    --Spam text
    
    function spamDialog()
    return [[
set_default_color|`7
add_label_with_icon|big|`0Auto Spam Text                   |left|15442|
add_spacer|small|
add_smalltext|Input spam text:|
add_text_input|spamtext||]]..spamText..[[|50|
add_smalltext|Delay:|
add_text_input|delay||]]..delay..[[|5|
add_smalltext|`4Note`0: `9Please input delay 1 number(ex: if u want use delay 5000ms, please input 5)|
add_spacer|big|
end_dialog|spamtextpage|Cancel|Start Spamming|
]]
end
    if packet:find("dialog_name|spamtextpage") then
        -- Mendapatkan input teks spam dan delay
        local textInput = packet:match("spamtext|([^\n]+)") or ""
        local delayInput = packet:match("delay|([%d%.]+)") or ""

        -- Jika input valid, set variabel untuk teks spam dan delay
        if textInput == "" then
            spamText = "[ERROR: Text input is empty]"
        else
            spamText = textInput
        end

        if delayInput == "" then
            delayspm = 1  -- Jika delay kosong, gunakan default 1 detik
        else
            delayspm = tonumber(delayInput) or 1  -- Gunakan nilai default jika tidak valid
        end

        -- Aktifkan spamming
        spamTextActive = true  -- Mengaktifkan loop spamming

        -- Kirim dialog untuk kembali ke halaman spam text
        SendVariantList({
            [0] = "OnTextOverlay",
            [1] = "`0[ `2Auto Spam Text Active `0]",
        })
        return true
    end

    if packet:find("/stopspam") then
        spamTextActive = false 
        SendVariantList({
            [0] = "OnTextOverlay",
            [1] = "`0[ `4Auto Spam Text Stopped `0]",
        })
        return true
    end
    
    if packet:find("/spam") or packet:find("buttonClicked|spmtxt") then
        SendVariantList({
            [0] = "OnDialogRequest",
            [1] = spamDialog(),
        }, -1, 100)
        return true
    end
    
-- Emoji Command
if packet:find("/emoji") or packet:find("buttonClicked|emot") then
        local dialog = [[
add_label_with_icon|big|`0Manage Emoji|left|6002|
add_spacer|big|
text_scaling_string|Choose your emoji below:
]]
        for emoji, _ in pairs(emojiStatus) do
            dialog = dialog .. "add_checkbox|emoji_" .. emoji .. "|(" .. emoji .. ")|" .. multiboxChecker(emojiStatus[emoji]) .. "|\n"
        end
        dialog = dialog .. [[
add_spacer|big|
end_dialog|proxyemojiend|Close|Set|
]]
        SendVariantList({[0] = "OnDialogRequest", [1] = dialog})
        return true
    end

    for emoji, _ in pairs(emojiStatus) do
        if packet:find("emoji_" .. emoji .. "|1") then
            for resetEmoji, _ in pairs(emojiStatus) do
                emojiStatus[resetEmoji] = false
            end
            emojiStatus[emoji] = true
        elseif packet:find("emoji_" .. emoji .. "|0") then
            emojiStatus[emoji] = false
        end
    end

    if packet:find("/cc") or packet:find("buttonClicked|colortxt") then
    local dialog = [[
add_label_with_icon|big|`0Manage Chat Colors|left|2590|
add_spacer|big|
text_scaling_string|Choose your chat color below:
]]
    for code, description in pairs({
        ["0"] = "`0Default", ["1"] = "`1Light cyan", ["2"] = "`2Green", ["3"] = "`3Light blue",
        ["4"] = "`4Crazy red", ["5"] = "`5Pinky purple", ["6"] = "`6Brown", ["7"] = "`7Light gray",
        ["8"] = "`8Crazy orange", ["9"] = "`9Yellow", ["!"] = "`!Bright cyan", ["@"] = "`@Bright red/pink",
        ["#"] = "`#Bright purple", ["$"] = "`$Pale yellow", ["^"] = "`^Light green", ["&"] = "`&Very pale pink",
        ["w"] = "`wWhite", ["o"] = "`oDreamsicle", ["b"] = "`bBlack", ["p"] = "`pPink", ["q"] = "`qDark blue",
        ["e"] = "`eMedium blue", ["r"] = "`rPale green", ["t"] = "`tMedium green", ["a"] = "`aDark grey",
        ["s"] = "`sMed grey", ["c"] = "`cVibrant cyan", ["i"] = "`iBright yellow", ["rainbow"] = "`1=`2=`3=`4=`5=`6=`7=`8=`9=!",
        ["striped"] = "`1=`3=`1=`3=`1=`3=`1=`3=",
        ["triad"] = "`@=`3=`5=`@=`3=`5=`@=`3=`5=",
    }) do
        dialog = dialog .. "add_checkbox|color_" .. code .. "|" .. description .. "|" .. multiboxChecker(colorStatus[code]) .. "|\n"
    end
    dialog = dialog .. [[
add_spacer|big|
end_dialog|proxycolorend|Close|Set|
]]
    SendVariantList({[0] = "OnDialogRequest", [1] = dialog})
    return true
end

for code, _ in pairs(colorStatus) do
    if packet:find("color_" .. code .. "|1") then
        for resetCode, _ in pairs(colorStatus) do
            colorStatus[resetCode] = false
        end
        colorStatus[code] = true
    elseif packet:find("color_" .. code .. "|0") then
        colorStatus[code] = false
    end
end

if packet:find("action|input\n|text|([^\n]+)") then
    local txt = packet:match("action|input\n|text|([^\n]+)")
    local response = ""

    for emoji, value in pairs(emojiStatus) do
        if value then
            response = "(" .. emoji .. ") : "
            break
        end
    end

    local formattedText = response ~= "" and response .. " " or ""

    -- Kombinasi warna
    local rainbowColor = {"`1", "`2", "`3", "`4", "`5", "`6", "`7", "`8", "`9", "`!"}
    local stripedColor = {"`1", "`3"}
    local triadColor = {"`@", "`3", "`5"}
    local rainbowText = ""

    if colorStatus["rainbow"] then
        for i = 1, #txt do
            local char = txt:sub(i, i)
            local color = rainbowColor[((i - 1) % #rainbowColor) + 1]
            rainbowText = rainbowText .. color .. char
        end
    elseif colorStatus["striped"] then
        for i = 1, #txt do
            local char = txt:sub(i, i)
            local color = stripedColor[((i - 1) % #stripedColor) + 1]
            rainbowText = rainbowText .. color .. char
        end
    elseif colorStatus["triad"] then
        for i = 1, #txt do
            local char = txt:sub(i, i)
            local color = triadColor[((i - 1) % #triadColor) + 1]
            rainbowText = rainbowText .. color .. char
        end
    else
        -- Default color for each letter
        local colorText = ""
        local selectedColor = ""
        for code, value in pairs(colorStatus) do
            if value and code ~= "rainbow" and code ~= "striped" and code ~= "triad" then
                selectedColor = "`" .. code
                break
            end
        end
        for i = 1, #txt do
            colorText = colorText .. selectedColor .. txt:sub(i, i)
        end
        rainbowText = colorText
    end

    -- Send the formatted message
    SendPacket(2, "action|input\n|text|" .. formattedText .. rainbowText)
    return true
end


    return false
end)

function formatSpamText(text)
    local emojiPrefix = ""
    for emoji, value in pairs(emojiStatus) do
        if value then
            emojiPrefix = "(" .. emoji .. ") : "
            break
        end
    end

    local rainbowColor = {"`1", "`2", "`3", "`4", "`5", "`6", "`7", "`8", "`9", "`!"}
    local stripedColor = {"`1", "`3"}
    local triadColor = {"`@", "`3", "`5"}
    local selectedColor = ""
    local finalText = text

    if colorStatus["rainbow"] then
        -- Format teks dengan efek "rainbow"
        local rainbowText = ""
        for i = 1, #text do
            local char = text:sub(i, i)
            local color = rainbowColor[((i - 1) % #rainbowColor) + 1]
            rainbowText = rainbowText .. color .. char
        end
        finalText = rainbowText
    elseif colorStatus["striped"] then
        -- Format teks dengan efek "striped"
        local stripedText = ""
        for i = 1, #text do
            local char = text:sub(i, i)
            local color = stripedColor[((i - 1) % #stripedColor) + 1]
            stripedText = stripedText .. color .. char
        end
        finalText = stripedText
    elseif colorStatus["triad"] then
        -- Format teks dengan efek "triad"
        local triadText = ""
        for i = 1, #text do
            local char = text:sub(i, i)
            local color = triadColor[((i - 1) % #triadColor) + 1]
            triadText = triadText .. color .. char
        end
        finalText = triadText
    else
        -- Format teks dengan warna default (satu warna dipilih)
        for code, value in pairs(colorStatus) do
            if value and code ~= "rainbow" and code ~= "striped" and code ~= "triad" then
                selectedColor = "`" .. code
                break
            end
        end

        local colorText = ""
        for i = 1, #text do
            colorText = colorText .. selectedColor .. text:sub(i, i)
        end
        finalText = colorText
    end

    -- Tambahkan emoji prefix (jika ada)
    finalText = emojiPrefix .. finalText

    return finalText
end

function table.contains(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then return true end
    end
    return false
end

AddHook("onvariant", "proxy", function(var)
    -- Auto Wear Item Saat Mendapatkan World Lock
    if var[0] == "OnConsoleMessage" and var[1]:find("Collected") and var[1]:find("(%d+) World Lock") then
    jumlah = var[1]:match("(%d+) World Lock")
        s = tonumber(jumlah)
        log("`5Collected `0"..s.." `9World Lock")
        for _, inv in pairs(GetInventory()) do
            if inv.id == 242 then
                if inv.amount >= 100 or s >= 100 then
                    cdl = true
                    process_count = math.floor(s / 100)
                    if inv.amount < process_count * 100 then
                        process_count = math.floor(inv.amount / 100)
                    end
                end
            end
        end
        return true
    end

    -- Auto Convert Diamond Lock ke Blue Gem Lock
if var[0] == "OnConsoleMessage" and var[1]:find("(%d+) Diamond Lock") then
    jumlah = var[1]:match("(%d+) Diamond Lock")
    s = tonumber(jumlah)
    log("`5Collected `0"..s.." `1Diamond Lock")
    if acbgl == true then
        for _, inv in pairs(GetInventory()) do
            if inv.id == 1796 then
                if inv.amount >= 100 or s >= 100 then
                    cbgl = true
                    process_count = math.floor(s / 100)
                    if inv.amount < process_count * 100 then
                        process_count = math.floor(inv.amount / 100)
                    end
                end
            end
        end
    end
    return true
end

    -- Auto Convert Blue Gem Lock ke Black Gem Lock
    if var[0] == "OnConsoleMessage" and var[1]:find("Collected") and var[1]:find("(%d+) Blue Gem Lock") then
        jumlah = var[1]:match("(%d+) Blue Gem Lock")
        s = tonumber(jumlah)
        log("`5Collected `0"..s.." `eBlue Gem Lock")
        for _, inv in pairs(GetInventory()) do
            if inv.id == 7188 then
                if inv.amount >= 100 or s >= 100 then
                    cblk = true
                    process_count = math.floor(s / 100)
                    if inv.amount < process_count * 100 then
                        process_count = math.floor(inv.amount / 100)
                    end
                end
            end
        end
        return true
    end
    
    if var[0] == "OnConsoleMessage" and var[1]:find("Collected") and var[1]:find("(%d+) Black Gem Lock") then
    jumlah = var[1]:match("(%d+) Black Gem Lock")
        s = tonumber(jumlah)
        log("`5Collected `0"..s.." `bBlack Gem Lock")
        return true
    end

    -- Auto SDBlock
    if var[0] == "OnSDBroadcast" then
        ovl("`w[`2Auto Block `8SDB `w| `2Succes Block `8SDB`w]")
        return true
    end
    
    if var[0] == "OnDialogRequest" and var[1]:find("telephone") then
    if fbgl then
    pnX = var[1]:match("embed_data|x|(%d+)")
    pnY = var[1]:match("embed_data|y|(%d+)")
    SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..pnX.."|\ny|"..pnY.."|\nbuttonClicked|bglconvert")
    end
    return true
    end

    -- Log Spin dan Deteksi Fake

if var[0] == "OnTalkBubble" and var[2]:find("spun the wheel") then
    local isFake = var[2]:find("<") and var[2]:find(">")
    local spw = var[2]:match("`4(%d+)``!") or var[2]:match("`b(%d+)``!") or var[2]:match("`2(%d+)``!")
    local Reme, Qeme, Leme = 0, 0, 0

    if spw then
        if spw == "19" or spw == "28" then
            Qeme = spw % 10
        else
            local nmm, nmn = spw // 10, spw % 10
            Reme = (nmm + nmn) % 10
            Leme = (nmm + nmn) % 10
            Qeme = nmn
        end
    end

    -- Menentukan warna berdasarkan nilai
    local remeColor
    if Reme == 0 then
        remeColor = "`2" 
    elseif Reme % 2 == 0 then
        remeColor = "`b" 
    else
        remeColor = "`4" 
    end

    local lemeColor
    if Leme == 0 then
        lemeColor = "`2"
    elseif Leme % 2 == 0 then
        lemeColor = "`b"
    else
        lemeColor = "`4"
    end

    local qemeColor
    if Qeme == 0 then
        qemeColor = "`2"
    elseif Qeme % 2 == 0 then
        qemeColor = "`b"
    else
        qemeColor = "`4"
    end

    -- Membuat pesan dengan warna
    local variantMessage = (isFake and "`4[ FAKE ] " or "`2[ REAL ] ") .. var[2]
        if reme then
            variantMessage = variantMessage .. " `0[`cREME " .. remeColor .. Reme .. "`0]"
        end
        if leme then
            variantMessage = variantMessage .. " `0[`9LEME " .. lemeColor .. Leme .. "`0]"
        end
        if qeme then
            variantMessage = variantMessage .. " `0[`8QEME " .. qemeColor .. Qeme .. "`0]"
        end

    SendVariantList({
        [0] = "OnTalkBubble",
        [1] = var[1],
        [2] = variantMessage
    })

    if not isFake then
        if next(selectedPlayers) == nil then
            return false
        end

        for userid, playerName in pairs(selectedPlayers) do
            for _, player in pairs(GetPlayerList()) do
                if player.userid == userid and var[1] == player.netid then
                    if not table.find(playerLogs[userid], var[2]) then
                        table.insert(playerLogs[userid], var[2])
                        if #playerLogs[userid] > 10 then
                            table.remove(playerLogs[userid], 1)
                        end
                    end
                end
            end
        end
    end

    return true
end

if var[0] == "OnConsoleMessage" then
log(var[1])
return true
end

    return false
end)

function table.find(tab, value)
    for _, v in pairs(tab) do
        if v == value then
            return true
        end
    end
    return false
end

while true do
    Sleep(50)
    if dawlock then
if ireng then
drop(11550,ireng)
Sleep(500)
end
if bgl then
drop(7188,bgl)
Sleep(500)
end
if dl then
drop(1796,dl)
Sleep(500)
end
if wl then
drop(242,wl)
Sleep(500)
end
dawlock = false
end
-- Executed Drop Eat Tax
if DropMode then
        if ireng > 0 then
            drop(11550, ireng)
            Sleep(200)
        end
        if bgl > 0 then
            drop(7188, bgl)
            Sleep(200)
        end
        if dl > 0 then
            drop(1796, dl)
            Sleep(200)
        end
        if wl > 0 then
            drop(242, wl)
            Sleep(200)
        end
 
jatuh = nil
DropMode = false
-- End Drop Eat Tax
end
--Droping lock
if dwl then
    local amount = cekinv(242)
    local remaining = c - amount

    while remaining > 0 do
        tap(1796)
        Sleep(150)
        amount = cekinv(242)
        remaining = c - amount
    end

    drop(242, c)
    log("`2Drop `0"..c.. " `9World Lock")
    dwl = false
end
if ddl then
    local amount = cekinv(1796)
    local remaining = c - amount

    while remaining > 0 do
        tap(7188)
        Sleep(150)
        amount = cekinv(1796)
        remaining = c - amount
    end

    drop(1796, c)
    log("`2Drop `0"..c.. " `1Diamond Lock")
    ddl = false
end
if dbgl then
    local amount = cekinv(7188)
    local remaining = c - amount

    while remaining > 0 do
        SendPacket(2, "action|dialog_return\ndialog_name|info_box\nbuttonClicked|make_bluegl")
        Sleep(150)
        amount = cekinv(7188)
        remaining = c - amount
    end

    drop(7188, c)
    log("`2Drop `0"..c.. " `eBlue Gem Lock")
    dbgl = false
end
	if cdl then
	process_count = process_count or 1
    for i = 1, process_count do
	tap(242)
    Sleep(150)
    end 
	cdl = false
	end
	if acbgl then
	if cbgl then
    process_count = process_count or 1
    for i = 1, process_count do
        servers(nil, 32, nil, savedPositions.settelp.x, savedPositions.settelp.y)
        Sleep(200)
        SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..savedPositions.settelp.x.."|\ny|"..savedPositions.settelp.y.."|\nbuttonClicked|bglconvert")
        Sleep(200)
    end
    cbgl = false
end
	end
	if cblk then
	process_count = process_count or 1
    for i = 1, process_count do
    SendPacket(2, "action|dialog_return\ndialog_name|info_box\nbuttonClicked|make_bgl")
    Sleep(150)
    SendVariantList({[0] = "OnTalkBubble", [1] = GetLocal().netid, [2] = "`2Auto Convert `bBlack Gem Lock"})
    end
	cblk = false
	end
	if win1 then
	if savedPositions.st1.x and savedPositions.st1.y then
ireng = math.floor(jatuh/1000000)
bgl = math.floor(jatuh/10000)
jatuh = jatuh - bgl*10000 
dl = math.floor(jatuh/100)
wl = jatuh % 100
	eattax(savedPositions.st1.x, savedPositions.st1.y)
        tap(7188)
        Sleep(100)
        tap(1796)
        Sleep(100)
DropMode = true
hasil = (ireng ~= 0 and ireng.." `bBlack Gem Lock`9" or "`9").." "..(bgl ~= 0 and bgl.." `eBlue Gem Lock`9" or "`9").." "..(dl ~= 0 and dl.." `1Diamond Lock`9" or "`9").." "..(wl ~= 0 and wl.." `9World Lock`9" or "`9")
log("`w[`2Bet : `9"..Amount.."`w] `w[`2Tax : `9"..taxset.."%`w] `w[`2Drop : `9"..hasil.."`w]")
else
        log("`4Error: `cPosition 1 is not set.")
        ovl("`4Error: Position 1 is not set.")
    end
    win1 = false
    end
    if win2 then
    if savedPositions.st2.x and savedPositions.st2.y then
ireng = math.floor(jatuh/1000000)
bgl = math.floor(jatuh/10000)
jatuh = jatuh - bgl*10000 
dl = math.floor(jatuh/100)
wl = jatuh % 100
eattax(savedPositions.st2.x, savedPositions.st2.y)
tap(7188)
Sleep(100)
tap(1796)
Sleep(100)
DropMode = true
hasil = (ireng ~= 0 and ireng.." `bBlack Gem Lock`9" or "`9").." "..(bgl ~= 0 and bgl.." `eBlue Gem Lock`9" or "`9").." "..(dl ~= 0 and dl.." `1Diamond Lock`9" or "`9").." "..(wl ~= 0 and wl.." `9World Lock`9" or "`9")
log("`w[`2Bet : `9"..Amount.."`w] `w[`2Tax : `9"..taxset.."%`w] `w[`2Drop : `9"..hasil.."`w]")
else
        log("`4Error: `cPosition 2 is not set.")
        ovl("`4Error: Position 2 is not set.")
    end
    win2 = false
   end
   if cdrop then
if bgl then
drop(7188,bgl)
Sleep(500)
end
if dl then
drop(1796,dl)
Sleep(500)
end
if wl then
drop(242,wl)
Sleep(500)
end
Amount = nil
cdrop = false
end
if cdp then
bgl =math.floor(Amount/10000)
Amount = Amount - bgl*10000 
dl = math.floor(Amount/100)
wl = Amount % 100
c = tonumber (Amount)
taps(242,1796,c)
Sleep(100)
taps(1796,7188,c)
Sleep(100)
cdrop = true
hasil = (bgl ~= 0 and bgl.." `eBlue Gem Lock`9" or "`9").." "..(dl ~= 0 and dl.." `1Diamond Lock`9" or "`9").." "..(wl ~= 0 and wl.." `9World Lock`9" or "`9")
log("`2Drop `9"..hasil)
cdp = false
end
if ppv then
placeVertical()
ppv = false
end
if pph then
placeHorizontal()
pph = false
end
    if spamTextActive then
        local formattedText = formatSpamText(spamText)
        SendPacket(2, "action|input\n|text|" .. formattedText)
        Sleep(delayspm * 1000)
    end
end
else
        log("`4ID anda tidak terdaftar")
    end