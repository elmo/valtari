  $(document).on('turbolinks:load', function() {
    $('#division1').change(function() {
        $.get("/admin/divisions", {
            name: 'division1',
            value: $("#division1").val()
        }
     );
    });

    $('#division2').change(function() {
        $.get("/admin/divisions", {
            name: 'division2',
            value: $("#division2").val()
        }
     );
    });

    $('#division3').change(function() {
        $.get("/admin/divisions", {
            name: 'division3',
            value: $("#division3").val()
        }
     );
    });

    $('#division4').change(function() {
        $.get("/admin/divisions", {
            name: 'division4',
            value: $("#division4").val()
        }
     );
    });

    $('#division5').change(function() {
        $.get("/admin/divisions", {
            name: 'division5',
            value: $("#division5").val()
        }
     );
    });

   $('#show_divisions').change(function() { $('#business-search').submit(); });
   $('.collapsible').collapsible();
   $('#show_all').change(function() { $('#business-search').submit(); });

  });
