<?php $app->assetter()->load('bootbox'); ?>

<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <h1>
                <i class="fa fa-bolt"></i>
                <?php echo $app->t($tax->getId() ? 'taxEdit' : 'taxNew'); ?>
            </h1>
        </div>
        <div class="heading-elements">
            <div class="heading-btn-group">
                <a href="#" data-form-submit="form" data-form-param="apply" class="btn btn-icon-block btn-link-success">
                    <i class="fa fa-save"></i>
                    <span>{{ t('apply') }}</span>
                </a>
                <a href="#" data-form-submit="form" data-form-param="save" class="btn btn-icon-block btn-link-success">
                    <i class="fa fa-save"></i>
                    <span>{{ t('save') }}</span>
                </a>
                <a href="#" class="btn btn-icon-block btn-link-danger app-history-back">
                    <i class="fa fa-remove"></i>
                    <span>{{ t('cancel') }}</span>
                </a>
            </div>
        </div>
        <div class="heading-elements-toggle">
            <i class="fa fa-ellipsis-h"></i>
        </div>
    </div>
    <div class="breadcrumb-line">
        <ul class="breadcrumb">
            <li><a href="{{ createUrl() }}"><i class="fa fa-home"> </i>Verone</a></li>
            <li><a href="{{ createUrl('Tax', 'Tax', 'index') }}">{{ t('modNameTax') }}</a></li>
            @if $tax->getId()
                <li class="active"><a href="{{ createUrl('Tax', 'Tax', 'edit', [ 'id' => $tax->getId() ]) }}">{{ t('taxEdit') }}</a></li>
            @else
                <li class="active"><a href="{{ createUrl('Tax', 'Tax', 'add') }}">{{ t('taxNew') }}</a></li>
            @endif
        </ul>
    </div>
</div>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <form action="<?php echo $app->createUrl('Tax', 'Tax', $tax->getId() ? 'update' : 'save'); ?>" method="post" id="form" class="form-validation">
                <input type="hidden" name="id" value="{{ $tax->getId() }}" />
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">{{ t('basicInformations') }}</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="name" class="control-label">{{ t('taxName') }}</label>
                                    <input class="form-control required" type="text" id="name" name="name" autofocus="" value="{{ $tax->getName() }}" />
                                </div>
                                <div class="form-group">
                                    <label for="rate" class="control-label">{{ t('taxRate') }} <a href="#" class="btn-taxrate-help help-inline" data-toggle="tooltip" title="{{ t('help') }}"><i class="fa fa-support"></i></a></label>
                                    <input class="form-control required" type="text" id="rate" name="rate" value="{{ $tax->getRate() }}" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $('.btn-taxrate-help').click(function() {
        bootbox.helpdialog('{{ t('taxRateHelpTitle') }}', '{{ t('taxRateHelpContent') }}');
    });
</script>
