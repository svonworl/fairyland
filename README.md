# fairyland
This is a proposed public test repository for rapid testing of certain workflows. **Absolutely no gurantees or warranties are made about the workflows contained herein, as they are still in development.** Do not run anything in here on "real data."

Developers should **not** use this as their development branch. Instead, it should import workflows from elsewhere using a https import pointing at a specific commit, or by manually mirroring from elsewhere. Use this only for rapid testing. Branches will be pruned regularly. Do not use this as a backup.

## Non-exhaustive contents

### ab.wdl
The WDL spec says...
> As with inputs, the outputs can reference previous outputs in the same block. The only requirement is that the output being referenced must be specified before the output which uses it.
>
> output {
>  String a = "a"
>  String ab = a + "b"
>}

...but does this work on Terra? --> Yes it does!

### borrowed_code
Testing a CWL tool --> CWL workflow wrapper. Original CWL tool by Stephanie Gogarten. Wrapper by Walt Shands.

### ld_pruning
Modified from the ld_pruning WDL I wrote for [analysis_pipeline_wdl](https://github.com/DataBiosphere/analysis_pipeline_WDL).

### underscores.wdl
Demonstrates that underscores at the beginning of a variable declaration, but not the end, will cause failure to validate using womtool.

### unpredict.wdl
Getting outputs with unpredictible file names is unintutive, but it is possible.