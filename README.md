# Εργασία στο μάθημα ανάλυση δεδομένων
Ιανουάριος 2020
Δημήτρης Κουγιουμτζής

### Ζητήµατα εργασίας
Η εργασία αφορά δασικές εκτάσεις, όπου κάποιες είναι καµµένες, και δίνονται για κάθε έκταση γεωγραφικοί, εποχικοί και περιβαλλοντικοί δείκτες.
Η µελέτη έγινε σε µια περιοχή της Πορτογαλίας (Montesinho). Τα δεδοµένα
έχουν δοθεί από την πηγή : P. Cortez and A. Morais. A Data Mining Approach to Predict Forest Fires using Meteorological Data. In J. Neves, M. F.
Santos and J. Machado Eds., New Trends in Artificial Intelligence, Proceedings of the 13th EPIA 2007 - Portuguese Conference on Artificial Intelligence, December, Guimaraes, Portugal, pp. 512-523, 2007. (το άρθρο είναι
διαθέσιµο στη διεύθυνση http://www3.dsi.uminho.pt/pcortez/fires.pdf)

Η οργάνωση των δεδοµένων δίνεται παρακάτω :
1. X x-axis spatial coordinate within the Montesinho park map: 1 to 9
2. Y y-axis spatial coordinate within the Montesinho park map: 2 to 9
3. month month of the year: number from 1 to 12 corresponding from "jan"
to "dec"
4. day day of the week: from 1 for Monday to 7 for Sunday
5. FFMC FFMC index from the FWI system: 18.7 to 96.20
6. DMC DMC index from the FWI system: 1.1 to 291.3
7. DC DC index from the FWI system: 7.9 to 860.6
8. ISI ISI index from the FWI system: 0.0 to 56.10
9. temp temperature in Celsius degrees: 2.2 to 33.30
10. RH relative humidity in %: 15.0 to 100
11. wind wind speed in km/h: 0.40 to 9.40
12. rain outside rain in mm/m2 : 0.0 to 6.4
13. area the burned area of the forest (in ha): 0.00 to 1090.84
(this output variable is very skewed towards 0.0, thus it may
make sense to model with the logarithm transform).

Για όλα τα Ϲητήµατα στην αρχή του κάθε προγράµµατος ϑα ϕορτώνεται το
αρχείο των δεδοµένων

#### Ζήτημα 1ο
1. Θέλουµε να συγκρίνουµε αν η κατανοµή δεικτών διαφέρει στις περιπτώσεις εκτάσεων καµµένων δασών και εκτάσεων χωρίς καµµένα δάση και
αν η κατανοµή σε κάθε περίπτωση είναι κανονική. Χώρισε τα δεδοµένα
σε δύο υποσύνολα ως εξής. Το πρώτο υποσύνολο, δείγµα Α, ϑα έχει τις
µετρήσεις που αντιστοιχούν σε µηδενική έκταση καµµένων δασών, δηλαδή είναι οι περιπτώσεις που η τελευταία στήλη (area) έχει τιµή µηδέν.
Το δεύτερο υποσύνολο, δείγµα Β, ϑα έχει τις υπόλοιπες µετρήσεις. Θα
διερευνήσεις την τυχόν διαφορά ποιοτικά από την κατανοµή του δείκτη
σε κάθε µια από τις δύο περιπτώσεις. Για αυτό ϑα σχηµατίσεις την καµπύλη της εµπειρικής συνάρτησης πυκνότητας πιθανότητας (σππ) του
δείκτη µε τη µέθοδο του ιστογράµµατος για κατάλληλη ισοµερή διαµέριση στις δύο περιπτώσεις (δύο καµπύλες σε ένα σχήµα). Επίσης
για κάθε ένα από τα δύο δείγµατα Α και Β ϑα ελέγξεις (µε έλεγχο υπόθεσης καλής προσαρµογής X2
) αν η αντίστοιχη σππ προσεγγίζεται
από κανονική κατανοµή. Αν δεν προσεγγίζεται από κανονική κατανοµή, ϑα κάνεις τον ίδιο έλεγχο για κατανοµή Poisson. Το πρόγραµµα
ϑα εφαρµόζει τα παραπάνω για κάθε έναν από τους δείκτες 9,10,11
(ϑερµοκρασία (temp), υγρασία (RH) και άνεµο (wind)) και ϑα δίνει για
κάθε δείκτη και σε κάθε µια από τις δύο περιπτώσεις την κατανοµή
που ακολουθεί. Συµφωνούν οι κατανοµές στις δύο περιπτώσεις και για
ποιους δείκτες ;

#### Ζήτημα 2ο
2. Σε συνέχεια του Ζητήµατος 1, ϑέλουµε να εξετάσουµε αν οι µέσες τιµές
του δείκτη διαφέρουν στις δύο περιπτώσεις (καµµένες και µη-καµµένες
δασικές εκτάσεις) και κατά πόσο όταν ϑεωρούµε το δείγµα όλων των παϱατηρήσεων και όταν χρησιµοποιούµε ένα µικρό δείγµα. Με ϐάση τα
δείγµατα Α και Β όλων των παρατηρήσεων (δες Ζήτηµα 1), υπολόγισε
το 95% διάστηµα εµπιστοσύνης για τη διαφορά των µέσων τιµών του
δείκτη στην περίπτωση µηδενικής καµµένης έκτασης και στην αντίθετη
περίπτωση. Κάνε το ίδιο για ένα µεγάλο πλήθος M, π.χ. M = 50,
µικρότερων δειγµάτων n = 20 παρατηρήσεων µε τυχαία επιλογή των
παρατηρήσεων από το κάθε ένα από τα δείγµατα Α και Β αντίστοιχα.
Σχηµάτισε τα διαστήµατα εµπιστοσύνης για τα M µικρά δείγµατα και
το διάστηµα εµπιστοσύνης για τα µεγάλα δείγµατα Α και Β (σε ένα ή δύο
σχήµατα). Συµφωνούν οι απαντήσεις από τα µεγάλα δείγµατα Α και Β
και τα M µικρά δείγµατα στο ερώτηµα για την ισότητα των µέσων τιµών
του δείκτη στις δύο περιπτώσεις (καµµένες και µη-καµµένες δασικές
εκτάσεις); Το πρόγραµµα ϑα εφαρµόζει τα παραπάνω (και ϑα απαντάει στο παραπάνω ερώτηµα) για κάθε έναν από τους δείκτες 9,10,11
(ϑερµοκρασία (temp), υγρασία (RH) και άνεµο (wind)).

#### Ζήτημα 3ο
3. Σε συνέχεια του Ζητήµατος 1, ϑέλουµε να εξετάσουµε αν οι διάµεσοι
(median) του δείκτη διαφέρουν στις δύο περιπτώσεις (καµµένες και µηκαµµένες δασικές εκτάσεις) και κατά πόσο όταν ϑεωρούµε το δείγµα
όλων των παρατηρήσεων και όταν χρησιµοποιούµε ένα µικρό δείγµα.
Με ϐάση τα δείγµατα Α και Β όλων των παρατηρήσεων (δες Ζήτηµα 1),
κάνε έλεγχο υπόθεσης (σε επίπεδο σηµαντικότητας α = 0.05) για την
ισότητα των διαµέσων του δείκτη στην περίπτωση µηδενικής καµµένης
έκτασης και στην αντίθετη περίπτωση. Για τον έλεγχο ϑα χρησιµοποιήσεις έλεγχο τυχαιοποίησης (τυχαίας αντιµετάθεσης) ή έλεγχο bootstrap
δηµιουργώντας B = 1000 τυχαία δείγµατα χωρίς επανάθεση ή µε επανάθεση, αντίστοιχα. Κάνε το ίδιο για ένα µεγάλο πλήθος M, π.χ.
M = 50, µικρότερων δειγµάτων n = 20 παρατηρήσεων µε τυχαία ε3
πιλογή των παρατηρήσεων από το κάθε ένα από τα δείγµατα Α και Β
αντίστοιχα. Συµφωνούν οι απαντήσεις (απόρριψη ή µη-απόρριψη της
µηδενικής υπόθεσης για ίσες διαµέσους του δείκτη στις δύο περιπτώσεις καµµένων και µη-καµµένων δασικών εκτάσεων) από τα µεγάλα
δείγµατα Α και Β και τα M µικρά δείγµατα ; Το πρόγραµµα ϑα εφαρµόζει τα παραπάνω (και ϑα απαντάει στο παραπάνω ερώτηµα) για κάθε
έναν από τους δείκτες 9,10,11 (ϑερµοκρασία (temp), υγρασία (RH) και
άνεµο (wind)).

#### Ζήτημα 4ο
4. Θέλουµε να διερευνήσουµε αν υπάρχει συσχέτιση µεταξύ των δεικτών
ανά Ϲεύγη. Από το σύνολο των παρατηρήσεων, επέλεξε τυχαία ένα µικρό
δείγµα 40 παρατηρήσεων για όλους τους δείκτες (δηλαδή 40 εκτάσεις
από το σύνολο των εκτάσεων µε τις αντίστοιχες τιµές των δεικτών). Με
ϐάση αυτό το δείγµα, κάνε κατάλληλο παραµετρικό έλεγχο για µηδενική συσχέτιση για κάθε Ϲεύγος, χρησιµοποιώντας το στατιστικό της
κατανοµής Student. Κάνε επίσης τον αντίστοιχο έλεγχο τυχαιοποίησης
χρησιµοποιώντας B = 1000 τυχαιοποιηµένα δείγµατα. Φαίνεται να υπάρχει κάποια συσχέτιση µεταξύ των δεικτών και ποιών µε ϐάση τον
παραµετρικό και έλεγχο τυχαιοποίησης για κάθε Ϲεύγος δεικτών από
τους δείκτες 5,...,11 (FFMC,...,wind); Συµφωνούν οι δύο τύποι ελέγχου
υπόθεσης ;

#### Ζήτημα 5ο
5. Θέλουµε να διερευνήσουµε αν η υγρασία (RH) και ο άνεµος (wind) εξαρτώνται από τη ϑερµοκρασία (temp). Με ϐάση το δείγµα που επέλεξες
στο Ζήτηµα 4, εκτίµησε το µοντέλο γραµµικής παλινδρόµησης του RH
ως προς το temp, υπολόγισε το συντελεστή προσδιορισµού (ή εναλλακτικά τον προσαρµοσµένο συντελεστή προσδιορισµού) και διερεύνησε την
καταλληλότητα του µοντέλου (αν τα υπόλοιπα είναι ασυσχέτιστα). Επανέλαβε την παραπάνω ανάλυση για την εξάρτηση του δείκτη wind από
το temp. ∆ιαφέρουν τα αποτελέσµατα ; Σε ποια περίπτωση η προσαρµογή του µοντέλου παλινδρόµησης είναι καλύτερη ; Θα ήταν χρήσιµο
να επεκτείνουµε το µοντέλο παλινδρόµησης σε πολυωνυµικό κάποιου
ϐαθµού σε κάθε µια από τις δύο περιπτώσεις ;

#### Ζήτημα 6ο
6. Θέλουµε να διερευνήσουµε την ακρίβεια της εκτίµησης του συντελεστή
της γραµµικής παλινδρόµησης από µικρό δείγµα για την περίπτωση της
γραµµικής εξάρτησης της σχετική υγρασίας (RH) από τη ϑερµοκρασία
(temp). Θεωρούµε ως πραγµατικό συντελεστή β της γραµµικής παλινδρόµησης της υγρασίας από τη ϑερµοκρασία αυτόν που εκτιµούµε µε
τη µέθοδο ελαχίστων τετραγώνων στο σύνολο των Ϲευγαρωτών παρατηρήσεων ϑερµοκρασίας και υγρασίας. Θα δηµιουργήσεις M = 100 µικρά
Ϲευγαρωτά δείγµατα n = 40 παρατηρήσεων από το αρχικό σύνολο των
παρατηρήσεων ϑερµοκρασίας και υγρασίας. Για κάθε δείγµα ϑα υπολογίσεις το συντελεστή b της ευθείας ελαχίστων τετραγώνων, το αντίστοιχο παραµετρικό 95% διάστηµα εµπιστοσύνης, καθώς και το bootstrap
95% διάστηµα εµπιστοσύνης. Το bootstrap διάστηµα εµπιστοσύνης
για το συντελεστή γραµµικής παλινδρόµησης σχηµατίζεται µε ϐάση B
Ϲευγαρωτά δείγµατα bootstrap, όπου το κάθε δείγµα σχηµατίζεται από το σύνολο των Ϲευγαρωτών παρατηρήσεων µε επαναδειγµατοληψία
µε επανάθεση. Θα σχηµατίσεις την κατανοµή του b (ιστόγραµµα) από τα M µικρά δείγµατα και ϑα µετρήσεις το ποσοστό των αντίστοιχων
παραµετρικών και bootstrap διαστηµάτων εµπιστοσύνης (σε σύνολο M
διαστηµάτων) που περιέχουν την τιµή β, η οποία υπολογίστηκε στο σύνολο των παρατηρήσεων. Συµφωνούν τα ποσοστά για το παραµετρικό
και bootstrap διάστηµα εµπιστοσύνης ;

#### Ζήτημα 7ο
7. Θέλουµε να διερευνήσουµε αν η έκταση δασών (area, καµµένων ή µη)
µπορεί να εξαρτάται από κάποιον από τους άλλους παρατηρούµενες
δείκτες (στήλες 1 - 12). Η εξάρτηση µπορεί να είναι γραµµική ή µηγραµµική. Κάνε διερεύνηση του µοντέλου παλινδρόµησης της έκτασης
ως προς κάποιον δείκτη (µε ελεύθερη επιλογή του µοντέλου, γραµµικού, πολυωνυµικού, άλλου) που δίνει την καλύτερη προσαρµογή, δηλαδή δίνει τη µεγαλύτερη τιµή του προσαρµοσµένου συντελεστή προσδιορισµού. Η διερεύνηση ϑα γίνει ως προς κάθε έναν από τους 12
δείκτες.

#### Ζήτημα 8ο
8. Θέλουµε να ελέγξουµε το κατάλληλο µοντέλο πολλαπλής γραµµικής
παλινδρόµησης για τον άνεµο (wind). Η εφαρµογή του µοντέλου ϐηµατικής παλινδρόµησης στο σύνολο των παρατηρήσεων µπορεί να προσθέσει µεταβλητές που δεν έχουν σηµαντική προβλεπτική πληροφορία
για τον άνεµο, όπου οι µεταβλητές είναι οι δείκτες 1,...,10,12,13. Πρώτα ϑα εφαρµόσεις το µοντέλο ϐηµατικής παλινδρόµησης στο σύνολο των
παρατηρήσεων και ϑα κρατήσεις το σύνολο X0 των επεξηγηµατικών µεταβλητών που επιλέχτηκαν. Στη συνέχεια ϑα δηµιουργήσεις M = 100
µικρά Ϲευγαρωτά δείγµατα n = 40 παρατηρήσεων από το αρχικό σύνολο των παρατηρήσεων. Για κάθε δείγµα i = 1, . . . , M, ϑα εφαρµόσεις το
µοντέλο ϐηµατικής παλινδρόµησης και ϑα κρατήσεις το σύνολο Xi των
επεξηγηµατικών µεταβλητών που επιλέχτηκαν. Θα υπολογίσεις πόσο
συχνά εµφανίζεται κάθε µεταβλητή από το σύνολο X0 στα σύνολα Xi
i = 1, . . . , M. Φαίνεται κάποιες µεταβλητές του µοντέλου ϐηµατικής
παλινδρόµησης στο σύνολο των παρατηρήσεων (X0) να εµφανίζονται
συχνά στο σύνολο των µεταβλητών του µοντέλου ϐηµατικής παλινδρόµησης στα µικρά δείγµατα ;

#### Ζήτημα 9ο
9. Θέλουµε να εξετάσουµε αν οι 13 δείκτες έχουν πληροφορία που µπορεί
να παρασταθεί µε λιγότερες µεταβλητές, δηλαδή να διερευνήσουµε τη
µείωση διάστασης του χώρου των παρατηρήσιµων µεταβλητών. Για αυτό ϑα εφαρµόσεις την ανάλυση PCA στο σύνολο των δεδοµένων, αφού
έχουν κανονικοποιηθεί πρώτα, δηλαδή έγινε αφαίρεση µε τη µέση τιµή
και διαίρεση µε την τυπική απόκλιση για κάθε δείκτη ξεχωριστά. Αυτό
γίνεται γιατί οι δείκτες έχουν διαφορετικό εύρος τιµών που µπορεί να
επηρεάσει την PCA. Θα εκτιµήσεις τη διάσταση d ≤ 13 για τη µείωση
διάστασης µε PCA µε το λεγόµενο scree plot, όπου χρησιµοποιείται ως
κατώφλι η µέση τιµή των ιδιοτιµών λ¯ (οι ιδιοτιµές που είναι µεγαλύτερες
του λ¯ ϑεωρούνται σηµαντικές και το πλήθος τους συνιστά την εκτίµηση
του d). Θα δοκιµάσεις τον καθορισµό του d µε χρήση τυχαιοποιηµένων δειγµάτων. Κάθε τυχαιοποιηµένο δείγµα των 13 δεικτών παράγεται
µε τυχαία αντιµετάθεση των παρατηρήσεων της κάθε µεταβλητής. Θα
δηµιουργήσεις B = 1000 τυχαιοποιηµένα δείγµατα, ϑα εφαρµόσεις το
PCA σε κάθε ένα από αυτά και ϑα κρατήσεις τις 13 ιδιοτιµές για το
καθένα. Με αυτόν τον τρόπο σχηµατίζουµε την εµπειρική κατανοµή
της κάθε ιδιοτιµής λ1, . . . , λ13, αν οι 13 µεταβλητές ήταν ανεξάρτητες
µεταξύ τους. Ιδιοτιµές στο αρχικό δείγµα που είναι στην δεξιά ουρά
αυτής της εµπειρικής κατανοµής (για ανεξάρτητα δείγµατα) µπορούν
να ϑεωρηθούν στατιστικά σηµαντικές (ϑέτοντας κάποιο όριο σηµαντικότητας, π.χ. α = 0.05). Με αυτόν τον τρόπο ϑα ελέγξετε αν κάποιες (από
τις πρώτες) ιδιοτιµές είναι σηµαντικές και το πλήθος τους ϑα δώσει την
εκτίµηση του d µε τυχαιοποίηση. Συµφωνεί αυτή η εκτίµηση µε την
εκτίµηση του κατωφλίου λ¯;

#### Ζήτημα 10ο
10. Θέλουµε να ϐρούµε κατάλληλο µοντέλο πολλαπλής γραµµικής παλινδρόµησης για τη σχετική υγρασία (RH) από τις υπόλοιπες µεταβλητές.
Η διερεύνηση του κατάλληλου µοντέλου ϑα γίνει χωρίζοντας το σύνολο
των παρατηρήσεων σε δύο υποσύνολα (ελεύθερη επιλογή), στο σύνολο εκµάθησης (training set) στο οποίο ϑα εκτιµήσεις τους συντελεστές
του µοντέλου και στο σύνολο αξιολόγησης (validation set) στο οποίο ϑα
υπολογίσεις τα σφάλµατα και το στατιστικό του συντελεστή προσδιορισµού. Θα δοκιµάσεις το πλήρες µοντέλο παλινδρόµησης µε όλες τις 12
µεταβλητές καθώς και δύο µοντέλα παλινδρόµησης που εφαρµόζουν
µείωση διάστασης. Για τους δύο τύπους µοντέλων µε µείωση διάστασης
ϑα δοκιµάσεις διαφορετικές διαστάσεις d < 12. Θα συγκρίνεις το συντελεστή προσδιορισµού στο σύνολο αξιολόγησης µε το πλήρες µοντέλο
και τα µοντέλα µείωσης διάστασης για διαφορετικό d.
