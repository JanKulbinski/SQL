CREATE INDEX nazwisko_aktor USING BTREE ON  #nie bylo takiego index'u
aktorzy(nazwisko,imie(1));

CREATE INDEX tytul_film USING BTREE ON   #nie bylo takiego index'u
filmy(tytul);

CREATE INDEX aktor_zagrali USING BTREE ON #byl
zagrali(aktor_id) 
