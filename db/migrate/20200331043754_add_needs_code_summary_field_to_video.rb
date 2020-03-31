class AddNeedsCodeSummaryFieldToVideo < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :code, :text
    add_column :videos, :code_summary_state, :string, default: 'not_ready'
    # possible states:
    # not_ready
    # ready
    # started
    # finished
  end
end
