$(document).ready(function () {

    $('.expan, .ex, .corr, .reg').hide(); /* Interventi editoriali inizialmente nascosti */

    /* Gestione pulsanti categorie + colorazione testo + pulsante Ripulisci */
    $('.categ').click(function () {
        $(this).toggleClass('active');
        $btnId = $(this).attr('id');
        $color = $(this).css('background');
        if ($(this).hasClass('active')) {
            $(this).css('box-shadow', '0.5px 0.5px 10px red');
            $(this).css('transition', '0.3s ease');
            $('span.' + $btnId).css('background', $color);
            $("button#clean").click(function () {
                $('button').css('box-shadow', '0.5px 0.5px 2px grey');
                $('span.person, span.character, span.bibl, span.place, span.event, span.org, span.num, span.date, span.verbum, span.cit, span.foreign').css('background', 'transparent');
            });
        } else {
            $(this).css('box-shadow', '0.5px 0.5px 2px grey');
            $(this).css('transition', '0.3s ease');
            $('span.' + $btnId).css('background', 'transparent');
        }
    });


    /* tooltip con conteggio degli elementi per ogni categoria */
    $('.categ').hover(
        function () {
            let categoryId = $(this).attr('id');
            let count = $('span.' + categoryId).length; // conta gli elementi con la classe corrispondente

            // Mostra il tooltip con il conteggio
            $(this).attr('title', `Ci sono ${count} elementi in questa categoria`);
        },
        function () {
            // Rimuovi il tooltip quando si esce dall'hover
            $(this).removeAttr('title');
        }
    );

    

    /* Gestione pulsanti interventi + colorazione testo + pulsante Ripulisci */
    $('.int').click(function () { 
        $(this).toggleClass('active');
        $btnId = $(this).attr('id');
        $color = $(this).css('background');
        if ($(this).hasClass('active')) {
            $(this).css('box-shadow', '0.5px 0.5px 10px red');
            $(this).css('transition', '0.3s ease');
            $('span.' + $btnId).show();
            $('span.' + $btnId).css('background', $color);
            $("button#clean").click(function () {
                $('button').css('box-shadow', '0.5px 0.5px 2px grey');
                $('span.ex, span.expan, span.corr, span.reg').hide();
            });
        } else {
            $(this).css('box-shadow', '0.5px 0.5px 2px grey');
            $(this).css('transition', '0.3s ease');
            $('span.' + $btnId).hide();
        }
    });

    $("span.person, span.character, span.bibl, span.place, span.event, span.org").mouseover(function(){ 
        $(this).css("text-decoration", "underline");
        $(this).css("cursor", "pointer");
        $(this).next("span.info").css("visibility", "visible");
    });
    $("span.person, span.character, span.bibl, span.place, span.event, span.org").mouseout(function(){ 
        $(this).css("text-decoration", "none");
        $(this).next("span.info").css("visibility","hidden");
    });

    $("span.cit, span.glossario").mouseover(function(){ 
        $(this).next("span.info").css("visibility", "visible");
    });
    $("span.cit, span.glossario").mouseout(function(){ 
        $(this).next("span.info").css("visibility","hidden");
    });



    /* Gestione area interattiva facsimile area-span*/
    var previousSpan = null;
    
    $("area").click(function() {
        var dataCorr = $(this).attr("data-corresp"); 
        if (dataCorr.startsWith("#")) {
            var spanId = dataCorr.substring(1); 
            var spanCorr = $("#" + spanId); 
            if (previousSpan && previousSpan.length > 0) {
                previousSpan.removeClass('selected');
            }
            if (spanCorr.length > 0) {
                spanCorr.addClass('selected');
                $('html, body').animate({
                    scrollTop: spanCorr.offset().top - 273
                }, 700);
                previousSpan = spanCorr;
            }
        }
    });


    /* Gestione area interattiva facsimile span-area */
    $("span").click(function () {

        var spanId = $(this).attr("id");
        if (!spanId) {
            console.log("Errore: Lo span selezionato non ha un id.");
            return;
        }
    
        // Rimuove la classe 'selected' da tutti gli span e la aggiunge solo a quello cliccato
        $("span").removeClass("selected");
        $(this).addClass("selected");
      
        // Cerca l'area corrispondente usando il valore di data-corresp
        var areaCorr = $("area[data-corresp='#" + spanId + "']");
        if (areaCorr.length > 0) {

            // Mappa degli offset di scroll
            var offsetMap = {

                // Collegamenti in cima alla pagina
                "p175_tit": -250, "p175_p1": -250, "p175_p3f": -250,
                "p176_p1": -250, "p176_p3f": -250, "p177_p1": -250,
                "p177_p3f": -250, "p178_p1": -250, "p271_p1": -250,
                "p271_p3f": -250, "p272_p1": -250, "p272_p3f": -250,
                "bibl1_p275_p1": -250, "bibl2_p275_p3f": -250,
                "p338_p1": -250, "p338_p3f": -250, "p339_p1": -250,
                "p339_p4f": -250,
    
                // Collegamenti a fine pagina
                "p175_p6": 600, "p175_n1": 600, "p175_n2": 600,
                "p177_p6": 600, "p177_p7": 600, "p178_aut": 600,
                "p270_tit": 600, "p270_p1": 600, "p271_n1": 600,
                "p271_n2": 600, "bibl2_p275_p3i": 600, "bibl2_nota": 600,
                "p338_p5": 600,

                //art1
                "p175_p2": 147, "p175_p3i": 475, "p175_p4": 5,
                "p175_p5": 430, "p177_p2": 125, "p176_p6": 566,
                "p177_p5": 154, 

                //art2
                "p271_p2": -25, "p271_p3i": 380,
                "p271_p4": 65, "p272_p2": -55, "p272_p3i": 155,
                "p272_p4": 90, "p272_aut": 90, 

                //biblio
                "bibl_titolo": 25, "bibl1_categoria": 25,
                "bibl1_titolo": 25, "bibl1_p274_p1": 100,
                "bibl1_p274_p2": 540,"bibl1_p275_p2": 160, 
                "bibl1_p275_p3": 290,"bibl2_categoria": 460, 
                "bibl2_titolo": 460,"bibl2_p275_p6": 460,
                "bibl2_p275_p1": 525,"bibl2_p275_p2": 570,
                "bibl2_p275_p4": 40,"bibl2_p275_p5": 145,

                //sezione notizie
                "not_tit": -55,"not_4": 230, 
                "not_6": 360, 

                //art3
                "p337_tit": 150,"p337_p1": 150, "p337_p2": 500,
                "p338_p2": -50,"p338_p3i": 325, 
                "p338_p4": 76, "p339_p2": 15,
                "p339_p3": 285, "p339_p4i": 425
            };
    
            // Calcola l'offset di scroll
            var scrollOffset = areaCorr.offset().top + (offsetMap[spanId] || -273);
    
            // Scrolla fino all'area con l'offset calcolato
            $('html, body').animate({
                scrollTop: scrollOffset
            }, 700);
        } else {
            console.log("Nessuna area trovata per span con id:", spanId);
        }
    });
    
});



