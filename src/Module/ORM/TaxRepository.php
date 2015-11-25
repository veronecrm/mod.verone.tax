<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Tax\ORM;

use CRM\ORM\Repository;

class TaxRepository extends Repository
{
    public $dbTable = '#__tax';

    public function getFieldsNames()
    {
        return [
            'name'   => $this->t('taxName'),
            'rate'   => $this->t('taxRate')
        ];
    }
}
