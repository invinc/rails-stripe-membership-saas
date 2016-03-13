$(function() {
    $('#change_card_form input[type=submit]').on('click', function(event) {
        event.preventDefault();

        var $button = $(this),
            $form = $button.parents('form');

        var opts = $.extend({}, $button.data(), {
            token: function(result) {
                $form.append($('<input>').attr({ type: 'hidden', name: 'stripeToken', value: result.id })).submit();
            }
        });

        StripeCheckout.open(opts);
    });

    // // total meals spinner
    // var total_meal_number = 6
    // var updated_total_meal_number = total_meal_number
    // var total_green = 0
    // var updated_green= total_green
                                                    
    // $('#total_meals_spinner').TouchSpin({
    //   min: 6,
    //   max: 34,
    //   step: 2
    // });

      
    // $('#green_meals_spinner').TouchSpin({
    //     min: 0,
    //     max: updated_total_meal_number,
    //     step: 1
    // });
})