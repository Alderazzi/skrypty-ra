cecho("\n<CadetBlue>(ra)<tomato>: Laduje plugin arkadia-ra\n")

-- definicja globalnych zmiennych
ra = { 
  version = "0.130",

  test_stage = false,
  debug = false,
  auto_switch_releasing_guards = true,
  tmp = {
    equipment = {},
    enemylist = {},
    peoples_off_coat = {},
    peoples_in_coat = {},
    coat_counter = 0,
    keyrooms = {},
    best_path = {},
    money = {},
    bank_transaction_cost = 0,
    dijkstra = nil,
    page_response = nil,
    ra_login_token = "",
    ra_login_timestamp = 0,
    last_room_color = 0,
    enemies = {},
    magic_items_cache = {},
    notify = {},
    orders = {},
    plugin_version = 0,
  },
  tsp = {},
  core = {},
  mail = {
    pre_text = "Amici! Familia prosi Cie o wsparcie.",
    post_text = "",
  },
  
  equipment = {},
  carrige = {},
  
  window_enabled = true,
  window_time_in = 60*4, -- w minutach, wrzuc eventy X min przed rozpoczeciem
  window_time_out = 30, -- w minutach, wyrzuc eventy z listy starsze niz X monut temu (nie dziala)
  window_notify_post_time_keygivers = 30 * 60,
  window_notify_pre_time_keygivers = 24 * 60 * 60,

  window_auto_refresh_enable = false,
  window_show_calendar = true,
  window_show_keygivers = true,
  
  colors = {
    info_lamanie = "yellow",
    
    -- zaslony
    ktos_z_druzyny_zaslonil = "DeepSkyBlue",   
    twoja_udana_zaslona = "DeepSkyBlue",
    ktos_z_przeciwnikow_zaslonil_przed_toba = "DarkOrange", -- warn aby nie lamac
    ktos_z_przeciwnikow_zaslonil_przed_druzyna = "yellow",  -- warn bind na lamanie
    
    ktos_z_druzyny_niezaslonil = "DarkSlateBlue",
    twoja_nieudana_zaslona = "DarkSlateBlue",
    ktos_z_przeciwnikow_niezaslonil = "ansiYellow", 
    
    -- wycofanie w druzynie
    ktos_z_druzyny_sie_wycofal = "DeepSkyBlue",
    twoje_wycofanie = "DeepSkyBlue",
    twoje_nieudane_wycofanie = "DarkSlateBlue",
    -- wycofanie u przeciwnikow
    ktos_z_przeciwnikow_sie_wycofal = "yellow",
    
    -- wytracenie broni
    wytracono_ci_bron = "yellow",
    
    -- przelamanie z druzyny
    ktos_z_druzyny_przelamal = "green", -- bind na ponowienie ataku
    ktos_z_druzyny_nieprzelamal = "DarkSlateGrey",
    twoje_udane_przelamanie = "green",
    twoje_nieudane_przelamanie = "DarkSlateGrey",
    
    -- przelamanie przeciwnikow
    ktos_z_przeciwnikow_przelamal = "red",
    ktos_z_przeciwnikow_nieprzelamal = "ansiRed",
    
    -- blokowanie pozycja
    ktos_z_druzyny_zajmuje_pozycje_do_bloka = "tomato",
    ty_zajmujesz_pozycje_do_bloka = "sea_green",
    ktos_z_przeciwnikow_zajmuje_pozycje_do_bloka_ciebie = "tomato",
    ktos_z_przeciwnikow_zajmuje_pozycje_do_bloka_kogos = "tomato",
    
    -- blokowanie proba
    ktos_z_przeciwnikow_probuje_bloka_na_ciebie = "yellow",
    ktos_z_przeciwnikow_probuje_bloka_na_kims_z_druzyny = "yellow",
    ktos_z_druzyny_probuje_bloka_na_kims_z_przeciwnikow = "sea_green",
    ty_probujesz_do_bloka_kims = "sea_green",
    
    -- udane blokowanie
    ktos_z_przeciwnikow_blokuje_na_ciebie = "red",
    ktos_z_przeciwnikow_kogos_z_druzyny = "tomato",
    ktos_z_druzyny_kogos_z_przeciwnikow = "yellow",
    ty_blokujesz_kogos = "yellow",
    
    -- ominiecie bloku
    ktos_z_druzyny_omija_blok = "yellow",
    ktos_z_przeciwnikow_omija_blok = "yellow",
    
    -- ominiecie bloku
    ktos_omija_twoj_blok = "yellow",
    
    przestajesz_odcinac_blok = "yellow",
  },

  maxsteps = 150,
  maxtime = 24, -- 24h
  maxsteps = 150,
  keyroom_icon_color = "red",
  
  download_drops_int = 60*60,   -- w sekundach
  
  dc_webhook_magiken = "https://discord.com/api/webhooks/1142727053196664883/trzmwTP_fUVSpthQg6XnMQvALA9kB2xvCEakHzYMBvMHOvAVrSyj_5TFjI_ePCD72mUA",
  dc_webhook_bot = "https://discord.com/api/webhooks/1157400638074933268/OQ4lsVBAEUvJ2QWclcrep0neKoKl3hCQW9FRdGQamsk7OZNBdU8c6SwMozzym5pvZ90t",
  dc_webhook_timery = "https://discord.com/api/webhooks/1142880846496407552/t5RbTc0KB_gEX3t390cOGzRr2zDmYkPujTc9k8myj4-BA_iCTTOybm8dPKOiNFIq_w2g",
  dc_webhook_kalendarz = "https://discord.com/api/webhooks/1211024219283132437/2KfsQz_jaje3UFuSgWGiq1UZUiruXMb9tzqcbYGsZP7WuR9dc6aajZ2stxtR8x89ZO4J",
  dc_webhook_zlecenia = "https://discord.com/api/webhooks/1211023068919758969/9mY5dzhIvxW1KdmSlvGLPPxg9MzPvqaeslgwzH4_JYT5MYvA0TEPgQ0szG9c18Aqb8mr",
  dc_webhook_puf = "https://discord.com/api/webhooks/1237446359959732284/d1Xm8mshVEtM7BspAYvFRU462sCF7p6cvhRqVQGNRkkDD93CZqRxzlxhgR1NNYfeAOS6",
  
  enemylist = {},
  
  ra_login_page = "https://ra.codefx.net/api/auth/login",
  ra_enemies_page = "https://ra.codefx.net/api/enemies",
  
  ra_login_timeout = 4*60*60, -- 4h * 60 min * 60 sek
  
  orders_json_file_path = getMudletHomeDir() .. "/ra_orders.json",
  
  download_domain = "https://ra.codefx.net",
  download_plugin_domain = "https://skrypty-ra.s3.eu-west-1.amazonaws.com",
  download_files = {
    enemies = { 
      name = "wrogowie Alderazzi",
      source = "/api/enemies",
      table = "enemies",
      target_file = getMudletHomeDir() .. "/enemylist_ra.json",
      active = true,
      downloaded = false,
    },
    keygivers  = {
      name = "kluczodajki",
      source = "/api/keygivers",
      table = "keyGivers",
      target_file = getMudletHomeDir() .. "/keygivers.json",
      active = true,
      downloaded = false,
    },
    keygivers_drops  = {
      name = "dropy",
      source = "/api/keygivers/drops/?days=7",
      table = "keyGiverDrops",
      target_file = getMudletHomeDir() .. "/keygivers_drops.json",
      active = true,
      downloaded = false,
    },    
    keys  = {
      name = "klucze",
      source = "/api/keys",
      table = "keys",
      target_file = getMudletHomeDir() .. "/keys.json",
      active = true,
      downloaded = false,
    },    
    plugin  = {
      name = "arkadia-ra",
      source = "/arkadia-ra.release",
      table = "plugin",
      target_file = getMudletHomeDir() .. "/arkadia-ra.release",
      active = true,
      downloaded = false,
    },    
  },
  
  alias = {},
  detox = {},
  orders = {},
}

if ra.test_stage then
  ra.dc_webhook_timery = ra.dc_webhook_bot
  ra.dc_webhook_magiken = ra.dc_webhook_bot
  ra.dc_webhook_kalendarz = ra.dc_webhook_bot
  ra.dc_webhook_zlecenia = ra.dc_webhook_bot
  ra.dc_webhook_puf = ra.dc_webhook_bot
  
  ra.ra_login_page = "https://ra-test.airm.ct8.pl/api/auth/login"
  ra.ra_enemies_page = "https://ra-test.airm.ct8.pl/api/enemies"
  
  ra.download_domain = "https://ra-test.airm.ct8.pl"
  ra.download_files = {
    enemies = { 
      name = "wrogowie Alderazzi",
      source = "/api/enemies",
      table = "enemies",
      target_file = getMudletHomeDir() .. "/enemylist_ra_test.json",
      active = true,
      downloaded = false,
    },
    keygivers  = {
      name = "kluczodajki",
      source = "/api/keygivers",
      table = "keyGivers",
      target_file = getMudletHomeDir() .. "/keygivers_test.json",
      active = true,
      downloaded = false,
    },
    keygivers_drops  = {
      name = "dropy",
      source = "/api/keygivers/drops",
      table = "keyGiverDrops",
      target_file = getMudletHomeDir() .. "/keygivers_drops_test.json",
      active = true,
      downloaded = false,
    },
    keys  = {
      name = "klucze",
      source = "/api/keys",
      table = "keys",
      target_file = getMudletHomeDir() .. "/keys_test.json",
      active = true,
      downloaded = false,
    },    
    plugin  = {
      name = "arkadia-ra",
      source = "/download/d2cce68e109aed17c4cfd3e5e7504a63/arkadia-ra.release",
      table = "plugin",
      target_file = getMudletHomeDir() .. "/arkadia-ra.release",
      active = true,
      downloaded = false,
    },    
  }
end
