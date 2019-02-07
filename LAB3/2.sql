CREATE INDEX koniec_kontrakty USING HASH ON 
Kontrakty(koniec);
drop index koniec_kontrakty on Kontrakty;

SELECT aktor_id
FROM aktorzy A
JOIN Kontrakty K
ON A.aktor_id = K.aktor
WHERE month(koniec) = month(now())+1
AND year(koniec) = year(now())

#access element H:O(1) B: O(logn) 
#H: can't select ranges O(n), whereas B: O(logn)
#H: only whole keys can be used to serch for a row, B: any leftmost prefix
#H:0,0022 sec / 0,000031 sec     B:0,0022 sec / 0,000036 sec