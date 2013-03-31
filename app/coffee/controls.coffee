#
# Controls
#
@App.Controls = {}

@App.Controls.MoneyTextField = Ember.TextField.extend({
  type: 'number'
  attributeBindings: [ 'step', 'style' ]
  step: 0.01
  size: 5
  style: 'width: 60px; padding: 0px 6px;'
})

@App.Controls.AmountTextField = Ember.TextField.extend({
  type: 'number'
  attributeBindings: [ 'step', 'style' ]
  step: 0.001
  size: 5
  style: 'width: 60px; padding: 0px 6px;'
})
