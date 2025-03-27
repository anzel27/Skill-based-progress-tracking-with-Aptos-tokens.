module MyModule::SkillProgress {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    struct SkillProgress has key, store {
        progress: u64,
    }

    /// Function to initialize skill progress for a user.
    public fun init_progress(user: &signer) {
        let progress = SkillProgress { progress: 0 };
        move_to(user, progress);
    }

    /// Function to update skill progress and reward with Aptos tokens.
    public fun update_progress(user: &signer, new_progress: u64, reward: u64) acquires SkillProgress {
        let progress_data = borrow_global_mut<SkillProgress>(signer::address_of(user));
        progress_data.progress = new_progress;

        // Reward the user with Aptos tokens
        let reward_tokens = coin::withdraw<AptosCoin>(user, reward);
        coin::deposit<AptosCoin>(signer::address_of(user), reward_tokens);
    }
}
