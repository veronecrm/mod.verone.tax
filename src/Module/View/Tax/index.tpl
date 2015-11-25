<?php
    $app->assetter()->load('input-switch');

    $acl = $app->acl('mod.Tax.Tax', 'mod.Tax');
    $canWrite  = $acl->isAllowed('core.write');
    $canRead   = $acl->isAllowed('core.read');
    $canDelete = $acl->isAllowed('core.delete');
?>

<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-bolt"></i>
                {{ t('modNameTax') }}
            </h1>
        </div>
        @if $canWrite
            <div class="heading-elements">
                <div class="heading-btn-group">
                    <a href="{{ createUrl('Tax', 'Tax', 'add') }}" class="btn btn-icon-block btn-link-success">
                        <i class="fa fa-plus"></i>
                        <span>{{ t('taxNew') }}</span>
                    </a>
                </div>
            </div>
            <div class="heading-elements-toggle">
                <i class="fa fa-ellipsis-h"></i>
            </div>
        @endif
    </div>
    <div class="breadcrumb-line">
        <ul class="breadcrumb">
            <li><a href="{{ createUrl() }}"><i class="fa fa-home"> </i>Verone</a></li>
            <li class="active"><a href="{{ createUrl('Tax', 'Tax', 'index') }}">{{ t('modNameTax') }}</a></li>
        </ul>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <table class="table table-default table-clicked-rows table-responsive">
                <thead>
                    <tr>
                        <th class="text-center span-1"><input type="checkbox" name="select-all" data-select-all="input_item" /></th>
                        <th>{{ t('taxName') }}</th>
                        <th>{{ t('taxRate') }}</th>
                        <th class="text-right">{{ t('action') }}</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach $elements
                        <tr<?php if($canRead): ?> data-row-click-target="{{ createUrl('Tax', 'Tax', 'edit', [ 'id' => $item->getId() ]) }}"<?php endif; ?>>
                            <td class="text-center hidden-xs"><input type="checkbox" name="input_item" value="{{ $item->getId() }}" /></td>
                            <td data-th="{{ t('taxName') }}" class="th">{{ $item->getName() }}</td>
                            <td data-th="{{ t('taxRate') }}"><?=number_format($item->getRate(), 3)?> %</td>
                            <td data-th="{{ t('action') }}" class="app-click-prevent">
                                @if $canRead || $canDelete
                                    <div class="actions-box">
                                        <div class="btn-group right">
                                            @if $canRead
                                                <a href="<?php echo $app->createUrl('Tax', 'Tax', 'edit', [ 'id' => $item->getId() ]); ?>" class="btn btn-default btn-xs btn-main-action" title="{{ t('edit') }}"><i class="fa fa-pencil"></i></a>
                                            @endif
                                            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                                <span class="caret"></span>
                                            </button>
                                            <ul class="dropdown-menu with-headline right">
                                                <li class="headline">{{ t('moreOptions') }}</li>
                                                @if $canRead
                                                    <li><a href="<?php echo $app->createUrl('Tax', 'Tax', 'edit', [ 'id' => $item->getId() ]); ?>" title="{{ t('edit') }}"><i class="fa fa-pencil"></i> {{ t('edit') }}</a></li>
                                                @endif
                                                @if $canDelete
                                                    <li role="separator" class="divider"></li>
                                                    <li class="item-danger"><a href="#" data-toggle="modal" data-target="#rate-delete" data-href="<?php echo $app->createUrl('Tax', 'Tax', 'delete', [ 'id' => $item->getId() ]); ?>" title="{{ t('delete') }}"><i class="fa fa-remove danger"></i> {{ t('delete') }}</a></li>
                                                @endif
                                            </ul>
                                        </div>
                                    </div>
                                @endif
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal fade" id="rate-delete" tabindex="-1" role="dialog" aria-labelledby="rate-delete-modal-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content modal-danger">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="{{ t('close') }}"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="rate-delete-modal-label">{{ t('taxDeleteConfirmationHeader') }}</h4>
            </div>
            <div class="modal-body">
                {{ t('taxDeleteConfirmationContent') }}
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ t('close') }}</button>
                <a href="#" class="btn btn-danger">{{ t('syes') }}</a>
            </div>
        </div>
    </div>
</div>
<script>
    $('#rate-delete').on('show.bs.modal', function (event) {
        $(this).find('.modal-footer a').attr('href', $(event.relatedTarget).attr('data-href'));
    });
</script>
