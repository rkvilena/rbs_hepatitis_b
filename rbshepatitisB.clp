;13520041 - Ilham Pratama
;13520074 - Eiffel Aqila Amarendra
;13520134 - Raka Wirabuana Ninagan
;---------------------------------
; Intro
(defrule inputread
   =>
   (printout t "HBsAg? " )
   (assert (HBsAg (read)))
)

; HBsAg rule -----------------------------------
(defrule hbsag_positive
   (HBsAg positive)
   =>
   (printout t "anti-HDV? ")
   (assert (anti-HDV(read))))

(defrule hbsag_negative
   (HBsAg negative)
   =>
   (printout t "anti-HBs? ")
   (assert (anti-HBs(read))))

(defrule hbsag_other "Considered as negative"
   ?HBsAg <- (HBsAg ?v)
   (not (or (HBsAg positive)
            (HBsAg negative)))
   =>
   (printout t "HBsAg value `" ?v "` is not `positive` or `negative`, we assume you mean `negative`...")
   (printout t crlf)
   (retract ?HBsAg)
   (assert (HBsAg negative)))

; anti-HDV rule -----------------------------------
(defrule antihdv_positive
   (anti-HDV positive)
   =>
   (printout t "Hasil Prediksi = Hepatitis B+D")
   (printout t crlf crlf)) ;TERMINAL

(defrule antihdv_negative
   (anti-HDV negative)
   =>
   (printout t "anti-HBc? ")
   (assert (anti-HBc(read))))

(defrule antihdv_other "Considered as positive"
   ?anti-HDV <- (anti-HDV ?v)
   (not (or (anti-HDV positive)
            (anti-HDV negative)))
   =>
   (printout t "anti-HDV value `" ?v "` is not `positive` or `negative`, we assume you mean `positive`...")
   (printout t crlf)
   (retract ?anti-HDV)
   (assert (anti-HDV positive)))

; anti-HBc rule -----------------------------------
(defrule antihbc1_positive
   (and 
      (anti-HDV negative)
      (anti-HBc positive))
   =>
   (printout t "anti-HBs? ")
   (assert (anti-HBs(read))))
(defrule antihbc1_negative
   (and 
      (anti-HDV negative)
      (anti-HBc negative))
   =>
   (printout t "Hasil Prediksi = Uncertain configuration")
   (printout t crlf crlf)) ;TERMINAL
(defrule antihbc1_other "Considered as negative"
   ?anti-HBc <- (anti-HBc ?v)
   (and 
      (anti-HDV negative)
      (not (or (anti-HBc positive)
               (anti-HBc negative))))
   =>
   (printout t "anti-HBc value `" ?v "` is not `positive` or `negative`, we assume you mean `negative`...")
   (printout t crlf)
   (retract ?anti-HBc)
   (assert (anti-HBc negative)))

(defrule antihbc2_positive
   (and 
      (HBsAg negative)
      (anti-HBs positive)
      (anti-HBc positive))
   =>
   (printout t "Hasil Prediksi = Cured")
   (printout t crlf crlf)) ;TERMINAL
(defrule antihbc2_negative
   (and 
      (HBsAg negative)
      (anti-HBs positive)
      (anti-HBc negative))
   =>
   (printout t "Hasil Prediksi = Vaccinated")
   (printout t crlf crlf)) ;TERMINAL
(defrule antihbc2_other "Considered as negative"
   ?anti-HBc <- (anti-HBc ?v)
   (and 
      (HBsAg negative)
      (anti-HBs positive)
      (not (or (anti-HBc positive)
               (anti-HBc negative))))
   =>
   (printout t "anti-HBc value `" ?v "` is not `positive` or `negative`, we assume you mean `negative`...")
   (printout t crlf)
   (retract ?anti-HBc)
   (assert (anti-HBc negative)))

(defrule antihbc3_positive
   (and
      (HBsAg negative)
      (anti-HBs negative)
      (anti-HBc positive))
   =>
   (printout t "Hasil Prediksi = Unclear (possible resolved)")
   (printout t crlf crlf)) ;TERMINAL
(defrule antihbc3_negative
   (and 
      (HBsAg negative)
      (anti-HBs negative)
      (anti-HBc negative))
   =>
   (printout t "Hasil Prediksi = Healthy no vaccinated or suspicious")
   (printout t crlf crlf)) ;TERMINAL
(defrule antihbc3_other "Considered as negative"
   ?anti-HBc <- (anti-HBc ?v)
   (and 
      (HBsAg negative)
      (anti-HBs negative)
      (not (or (anti-HBc positive)
               (anti-HBc negative))))
   =>
   (printout t "anti-HBc value `" ?v "` is not `positive` or `negative`, we assume you mean `negative`...")
   (printout t crlf)
   (retract ?anti-HBc)
   (assert (anti-HBc negative)))

; anti-HBs rule -----------------------------------
(defrule antihbs1_positive
   (and
      (anti-HDV negative)
      (anti-HBs positive))
   =>
   (printout t "Hasil Prediksi = Uncertain configuration")
   (printout t crlf crlf)) ;TERMINAL
(defrule antihbs1_negative
   (and
      (anti-HDV negative)
      (anti-HBs negative))
   =>
   (printout t "IgM anti-HBc? ")
   (assert (IgManti-HBc(read))))
(defrule antihbs1_other "Considered as negative"
   ?anti-HBs <- (anti-HBs ?v)
   (and 
      (anti-HDV negative)
      (not (or (anti-HBs positive)
               (anti-HBs negative))))
   =>
   (printout t "anti-HBs value `" ?v "` is not `positive` or `negative`, we assume you mean `negative`...")
   (printout t crlf)
   (retract ?anti-HBs)
   (assert (anti-HBs negative)))

(defrule antihbs2
   (and
      (HBsAg negative)
      (or
         (anti-HBs negative) 
         (anti-HBs positive)
      ))
   =>
   (printout t "anti-HBc? ")
   (assert (anti-HBc(read))))
(defrule antihbs2_other "Considered as negative"
   ?anti-HBs <- (anti-HBs ?v)
   (and 
      (HBsAg negative)
      (not (or (anti-HBs positive)
               (anti-HBs negative))))
   =>
   (printout t "anti-HBs value `" ?v "` is not `positive` or `negative`, we assume you mean `negative`...")
   (printout t crlf)
   (retract ?anti-HBs)
   (assert (anti-HBs negative)))

; IgM anti-HBc rule -----------------------------------
(defrule IgMantihbc_positive
   (and
      (anti-HBs negative) 
      (IgManti-HBc positive))
   =>
   (printout t "Hasil Prediksi = Acute infection")
   (printout t crlf crlf)) ;TERMINAL

(defrule IgMantihbc_negative
   (and
      (anti-HBs negative) 
      (IgManti-HBc negative))
   =>
   (printout t "Hasil Prediksi = Chronic infection")
   (printout t crlf crlf)) ;TERMINAL
(defrule IgMantihbc_other "Considered as negative"
   ?IgManti-HBc <- (IgManti-HBc ?v)
   (and 
      (anti-HBs negative) 
      (not (or (IgManti-HBc positive)
               (IgManti-HBc negative))))
   =>
   (printout t "IgManti-HBc value `" ?v "` is not `positive` or `negative`, we assume you mean `negative`...")
   (printout t crlf)
   (retract ?IgManti-HBc)
   (assert (IgManti-HBc negative)))