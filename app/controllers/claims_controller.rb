class ClaimsController < ApplicationController
  def new; end

  def show
    @claim = Claim.find(params[:id])
  end

  def create
    # TODO: several items can score alike — ask which one instead of taking the top.
    item = Item.unclaimed.where(created_at: 1.week.ago..).max_by(&S1.predicates.same_as(params[:body]))
    return redirect_to new_claim_path, notice: "Nothing like that has been handed in yet." unless item

    claim = Claim.new(item: item, story: params[:body])
    claim.save ? redirect_to(claim) : redirect_to(new_claim_path, alert: claim.errors.full_messages.to_sentence)
  end
end
