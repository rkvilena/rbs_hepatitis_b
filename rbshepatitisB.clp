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

; anti-HDV rule -----------------------------------
(defrule antihdv_positive
   (anti-HDV positive)
   =>
   (printout t "Hepatitis B+D")
   (printout t crlf crlf)) ;TERMINAL

(defrule antihdv_negative
   (anti-HDV negative)
   =>
   (printout t "anti-HBc? ")
   (assert (anti-HBc(read))))

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
   (printout t "Uncertain configuration")
   (printout t crlf crlf)) ;TERMINAL

(defrule antihbc2_positive
   (and 
      (HBsAg negative)
      (anti-HBs positive)
      (anti-HBc positive))
   =>
   (printout t "Cured")
   (printout t crlf crlf)) ;TERMINAL
(defrule antihbc2_negative
   (and 
      (HBsAg negative)
      (anti-HBs positive)
      (anti-HBc negative))
   =>
   (printout t "Vaccinated")
   (printout t crlf crlf)) ;TERMINAL

(defrule antihbc3_positive
   (and
      (HBsAg negative)
      (anti-HBs negative)
      (anti-HBc positive))
   =>
   (printout t "Unclear (possible resolved)")
   (printout t crlf crlf)) ;TERMINAL
(defrule antihbc3_negative
   (and 
      (HBsAg negative)
      (anti-HBs negative)
      (anti-HBc negative))
   =>
   (printout t "Healthy no vaccinated or suspicious")
   (printout t crlf crlf)) ;TERMINAL

; anti-HBs rule -----------------------------------
(defrule antihbs1_positive
   (and
      (anti-HDV negative)
      (anti-HBs positive))
   =>
   (printout t "Uncertain configuration")
   (printout t crlf crlf)) ;TERMINAL
(defrule antihbs1_negative
   (and
      (anti-HDV negative)
      (anti-HBs negative))
   =>
   (printout t "IgM anti-HBc? ")
   (assert (IgManti-HBc(read))))

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

; IgM anti-HBc rule -----------------------------------
(defrule IgMantihbs_positive
   (and
      (anti-HBs negative) 
      (IgManti-HBc positive))
   =>
   (printout t "Acute infection")
   (printout t crlf crlf)) ;TERMINAL

(defrule antihbs_negative
   (and
      (anti-HBs negative) 
      (IgManti-HBc negative))
   =>
   (printout t "Chronic infection")
   (printout t crlf crlf)) ;TERMINAL