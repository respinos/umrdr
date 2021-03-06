class DOIMintingJob < ActiveFedoraIdBasedJob
  queue_as :doi_minting
  def perform(id)
    @id = id
    work = object
    user = User.find_by_user_key(work.depositor)

    # Don't mint a handle if already has one
    return if work.doi

    if DoiMintingService.mint_doi_for work
      # do success callback
      if CurationConcerns.config.callback.set?(:after_doi_success)
        CurationConcerns.config.callback.run(:after_doi_success, work, user, log.created_at)
      end
    else
      # do failure callback
      if CurationConcerns.config.callback.set?(:after_doi_failure)
        CurationConcerns.config.callback.run(:after_doi_failure, work, user, log.created_at)
      end
    end
  end
end
