<?php
/**
 * Verone CRM | http://www.veronecrm.com
 *
 * @copyright  Copyright (C) 2015 Adam Banaszkiewicz
 * @license    GNU General Public License version 3; see license.txt
 */

namespace App\Module\Tax\Controller;

use CRM\App\Controller\BaseController;

/**
 * @section mod.Tax.Tax
 */
class Tax extends BaseController
{
    /**
     * @access core.module
     */
    public function indexAction($request)
    {
        return $this->render('', [
            'elements' => $this->repo()->findAll()
        ]);
    }

    /**
     * @access core.write
     */
    public function addAction()
    {
        return $this->render('form', [
            'tax' => $this->entity()
        ]);
    }

    /**
     * @access core.write
     */
    public function saveAction($request)
    {
        $tax = $this->entity()->fillFromRequest($request);

        $this->repo()->save($tax);

        $this->openUserHistory($tax)->flush('create', $this->t('taxTax'));

        $this->flash('success', $this->t('taxSaved'));

        if($request->get('apply'))
            return $this->redirect('Tax', 'Tax', 'edit', [ 'id' => $tax->getId() ]);
        else
            return $this->redirect('Tax', 'Tax', 'index');
    }


    /**
     * @access core.read
     */
    public function editAction($request)
    {
        $tax = $this->repo()->find($request->get('id'));

        if(! $tax)
        {
            $this->flash('danger', $this->t('taxDoesntExists'));
            return $this->redirect('Tax', 'Tax', 'index');
        }

        return $this->render('form', [
            'tax' => $tax
        ]);
    }

    /**
     * @access core.write
     */
    public function updateAction($request)
    {
        $tax = $this->repo()->find($request->get('id'));

        if(! $tax)
        {
            $this->flash('danger', $this->t('taxDoesntExists'));
            return $this->redirect('Tax', 'Tax', 'index');
        }

        $log = $this->openUserHistory($tax);

        $tax->fillFromRequest($request);

        $this->repo()->save($tax);

        $log->flush('change', $this->t('taxTax'));

        $this->flash('success', $this->t('taxUpdated'));

        if($request->get('apply'))
            return $this->redirect('Tax', 'Tax', 'edit', [ 'id' => $tax->getId() ]);
        else
            return $this->redirect('Tax', 'Tax', 'index');
    }

    /**
     * @access core.delete
     */
    public function deleteAction($request)
    {
        $tax = $this->repo()->find($request->get('id'));

        if(! $tax)
        {
            $this->flash('danger', $this->t('taxDoesntExists'));
            return $this->redirect('Tax', 'Tax', 'index');
        }

        $this->repo()->delete($tax);

        $this->openUserHistory($tax)->flush('delete', $this->t('taxTax'));

        $this->flash('success', $this->t('taxDeleted'));

        return $this->redirect('Tax', 'Tax', 'index');
    }
}
