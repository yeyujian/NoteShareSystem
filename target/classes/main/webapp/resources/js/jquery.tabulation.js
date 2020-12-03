(function ($) {

    function overrideObject(objOld, objNew) {

        var objCurrent = Object.assign({}, objOld);

        for (var i in objOld) {
            if (typeof objNew[i] === 'undefined')
                continue;
            else if (typeof objCurrent[i] === 'object' && typeof objNew[i] === 'object')
                objCurrent[i] = overrideObject(objCurrent[i], objNew[i]);
            else
                objCurrent[i] = objNew[i];
        }
        return objCurrent;
    }

    $.fn.tabulation = function ($settingsCustom) {

        if ($settingsCustom === undefined)
            $settingsCustom = {};

        this.each(function () {

            /**
             * Gets index of active tab
             * @returns active index or false
             */
            function activeGet() {
                var activeTab = $tabulation.filter('.' + $settings.tabulation.active.class);

                return (activeTab.length === 1) ? $tabulation.index(activeTab) : false;
            }

            /**
             * Setting tab to be active
             * @returns void
             */
            function activeSet(e) {
                var index;

                switch ($(this).data('tabulation-nav')) {
                    case 'prev':
                        index = activeGet() - 1;
                        break;
                    case 'next':
                        index = activeGet() + 1;
                        break;
                    default:
                        index = $(this).data('tabulation-nav') - 1;
                        break;
                }

                activateTab(index);
                e.preventDefault();
            }

            /**
             * Activate tab by index
             * @param {int} index Number of tab
             */
            function activateTab(index) {
                if (index >= 0 && index < $tabulation.length) {
                    $tabulation.hide().removeClass($settings.tabulation.active.class);
                    $tabulation.eq(index).show().addClass($settings.tabulation.active.class);

                    $navigation.removeClass($settings.navigation.active.class);
                    $navigation.filter('[data-tabulation-nav=' + (index + 1) + ']').addClass($settings.navigation.active.class);
                }
            }

            // Declare variables
            var $this, $tabulation, $navigation, $settings, $settingsDefault;

            // Default settings
            $settingsDefault = {
                navigation: {
                    active: {
                        class: 'active',
                    }
                },
                tabulation: {
                    active: {
                        class: 'active',
                    }
                }
            };

            $settings = overrideObject($settingsDefault, $settingsCustom);

            // Set variables for nodes
            $this = $(this);
            $tabulation = $this.find('[data-tabulation-tab]');
            $navigation = $this.find('[data-tabulation-nav]');

            // Add click events
            $navigation.click(activeSet);

            // Initialize
            activateTab(activeGet() === false ? 0 : activeGet());

        });

    };

})(jQuery);

$('[data-tabulation]').tabulation();