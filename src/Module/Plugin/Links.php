<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Tax\Plugin;

use CRM\App\Module\Plugin;

class Links extends Plugin
{
    public function dashboard()
    {
        if($this->acl('mod.Tax.Tax', 'mod.Tax')->isAllowed('core.module'))
        {
            return [
                [
                    'ordering' => 10,
                    'icon' => 'fa fa-bolt',
                    'icon-type' => 'class',
                    'name' => $this->t('taxTaxes'),
                    'href' => $this->createUrl('Tax', 'Tax')
                ]
            ];
        }
    }
}
